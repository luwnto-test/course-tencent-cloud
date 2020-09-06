<?php

namespace App\Console\Tasks;

use App\Library\Cache\Backend\Redis as RedisCache;
use Phalcon\Cli\Task;
use Phalcon\Config;

class CleanSessionTask extends Task
{

    public function mainAction()
    {
        $config = $this->getConfig();

        $cache = $this->getCache();

        $redis = $cache->getRedis();

        $redis->select($config->path('session.db'));

        $keys = $this->querySessionKeys(10000);

        if (count($keys) == 0) return;

        $lifetime = $config->path('session.lifetime');

        foreach ($keys as $key) {
            $ttl = $redis->ttl($key);
            $content = $redis->get($key);
            if (empty($content) && $ttl < $lifetime * 0.5) {
                $redis->del($key);
            }
        }
    }

    /**
     * 查找待清理会话
     *
     * @param int $limit
     * @return array
     */
    protected function querySessionKeys($limit)
    {
        $cache = $this->getCache();

        return $cache->queryKeys('_PHCR', $limit);
    }

    protected function getConfig()
    {
        /**
         * @var Config $config
         */
        $config = $this->getDI()->get('config');

        return $config;
    }

    protected function getCache()
    {
        /**
         * @var RedisCache $cache
         */
        $cache = $this->getDI()->get('cache');

        return $cache;
    }

}
