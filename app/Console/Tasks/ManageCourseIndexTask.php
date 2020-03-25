<?php

namespace App\Console\Tasks;

use App\Models\Course as CourseModel;
use App\Searchers\CourseDocument;
use App\Searchers\CourseSearch;
use Phalcon\Cli\Task;
use Phalcon\Mvc\Model\Resultset;
use Phalcon\Mvc\Model\ResultsetInterface;

class ManageCourseIndexTask extends Task
{

    /**
     * 搜索测试
     *
     * @command: php console.php manage_course_index search {query}
     * @param array $params
     * @throws \XSException
     */
    public function searchAction($params)
    {
        $query = $params[0] ?? null;

        if (!$query) {
            exit("please special a query word" . PHP_EOL);
        }

        $result = $this->searchCourses($query);

        var_export($result);
    }

    /**
     * 清空索引
     *
     * @command: php console.php manage_course_index clean
     */
    public function cleanAction()
    {
        $this->cleanCourseIndex();
    }

    /**
     * 重建索引
     *
     * @command: php console.php manage_course_index rebuild
     */
    public function rebuildAction()
    {
        $this->rebuildCourseIndex();
    }

    /**
     * 清空索引
     */
    protected function cleanCourseIndex()
    {
        $searcher = new CourseSearch();

        $index = $searcher->getXS()->getIndex();

        echo "start clean index" . PHP_EOL;

        $index->clean();

        echo "end clean index" . PHP_EOL;
    }

    /**
     * 重建索引
     */
    protected function rebuildCourseIndex()
    {
        $courses = $this->findCourses();

        if ($courses->count() == 0) {
            return;
        }

        $searcher = new CourseSearch();

        $documenter = new CourseDocument();

        $index = $searcher->getXS()->getIndex();

        echo "start rebuild index" . PHP_EOL;

        $index->beginRebuild();

        foreach ($courses as $course) {
            $document = $documenter->setDocument($course);
            $index->add($document);
        }

        $index->endRebuild();

        echo "end rebuild index" . PHP_EOL;
    }

    /**
     * 搜索课程
     *
     * @param string $query
     * @return array $result
     * @throws \XSException
     */
    protected function searchCourses($query)
    {
        $searcher = new CourseSearch();

        $result = $searcher->search($query);

        return $result;
    }

    /**
     * 查找课程
     *
     * @return Resultset|ResultsetInterface
     */
    protected function findCourses()
    {
        $courses = CourseModel::query()
            ->where('published = 1')
            ->execute();

        return $courses;
    }

}