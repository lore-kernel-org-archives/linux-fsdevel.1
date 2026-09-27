Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B63B6BFE
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 05:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790486264; cv=none; b=Jw/s7is12pTvdf12jDYM79Q6vwT2txAocvQ4VYU7yY6YNFZOZiNVv9sW7TTxrcZfjF0yYZfmjOImlYr5avefXMRrJZ5i8ZIfnj9L4ec/G9eI+sJx8QeXxOM/l94SJaMqYSep29AovV2kDzewB1LYurCgvxBx5dCjhxe59fMyEuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790486264; c=relaxed/simple;
	bh=SSmkElPyDxEYHWYFgGJzuCmYXCKp4WT/mcSA7J4Ux+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLAwwbbcQaULX1SNdRZ9CNTQqQutm8DxHBMF1XvZB8x8mxjMCJ11J/FUXZIrhFDn1B5VJyhZ927gZ28tdhEmlQlVjGLCjHiaRj/U1BnQV/UemBCBTDaka2C07H2r4UomI9T/4Vb6lmWnoXGBtt1rIptWyhBxMddjxU+F8deQZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdE0+JAf; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdE0+JAf"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-3468ec3097dso88362eec.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 22:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790486260; x=1791091060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BNvx6oU/daKEDtlWKz04FKMKbboc2AJpGlGKhS7HYzQ=;
        b=qdE0+JAfgT/bSh+xOvLZHqmAxLd4YBKPwoMwegGk4SQwhvjFeepURus6DKeQyU59lm
         0AJwl0a9hfVi3iayCQXbkCfGAJtA7M4bel7mOhpuj0NhmprsjlmpikZLQef6tblS3lBW
         nbaZWY8CzG5bHmOw/40Iq10eQ5YjY+JbRtiFlUvYpbLkLqRFWgnOeQ622jKsgZ8He6Ml
         BmRoRIzt/cjKhEpZyIbILE6yjXCyL0hMQ6fk1t1bbB1IKww6LJQ+fUkBYdtNnqpJKqKA
         4SbFyQVeoGIuj/gnViH7k6YCJFSu1INSpmmY1139fYqGlQ4CNgQS+oLb3Qrdjv+wMygE
         x05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790486260; x=1791091060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BNvx6oU/daKEDtlWKz04FKMKbboc2AJpGlGKhS7HYzQ=;
        b=mlehoinqh2YWI2fnnXSks3vx/WIFjHXcSbqgCVWmoDJ+ZwKWuwzfMlbEqaoD0UsJTu
         zjx5RpwDcMtSAs7TktnEBC0DOOMsLZD3CjvK3SaVJ898lEtfAw12VjtDmTwllomeRPk0
         CDwbKvVkqfEyax6/u0RwVjtbcfE5RH/IHw2/OhQeHrGLn6/5Y8Z9iHqthNQJ5K72+Ak8
         EyClm94DL3rZClJeLiq8PsjFzB/HXlAFkZU9y0ngiCuQj1IlwJLHf0eZvBfD55mqhKuU
         pvgQ33mpqvI7o6QuOIGqs517OqIFqSPuDGDh8eBDwFRsOj8GJn20kiABLqdGrPOrs188
         P6xQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7iW4WiuGACnnkTY7uxajUMW9dp09H5Lhn1sHSXufnhzTiHqgAWNYHDV0DCk927aTph1yrHclNzZzJZay6@vger.kernel.org
X-Gm-Message-State: AFq9FYIpqn8/HGw5bznInz6pDoLPZrO8zFBJB8bA9jlt36bLAGVoWuBT
	zqvLDGeFMYlWF800UxuvaBt5NR7iCmoYLJvss6qZngcbqLK2Ag0mJ7qO
X-Gm-Gg: AYBFou1/08tno7wJaKE82OzOmgmZZJYx//7SL9CMfOvBbByBIeX/iG+ZIQOZRtNIi2p
	FDrXmJ7wv1NMHRU9i09nLgY62CYJJ0240wLVM6Ez/ilh4K02KOk65bDkZqB/vQpKnEZc4PfGGEJ
	TKxEldbKQSuh/AP4RSvwOFhqcSarlHLMu+BC/HNI1fWGTyg9umJp04TXfLgRuz9rs/ODVD1C4OX
	r8mjmU7ci4uWnSgiBG/0S6ol7KDXLkcerkSnZNMr4XB8dk7fnA3KhIDWlz7xLv9OieZqcH124i6
	OG9w2nQYrupLHvIjOUq78zifViDVN7QLqYST9oyY0PvdC/BxpcyhSzS7AekukGe7oLowI72d1sM
	caBH9JK+g7Sjv5ZT/eHwrBPXnX39zmoqkPk8PTkANal4g5TNEpp853+xec+ykYYGfERqM9TwmlZ
	JjxRlsySsh0wg+fhalOHHGwTJRqGTiB8ewQpDuZf3oEvzLVn7XOJf/5CiobMhdjm7k9worZhA8H
	2ExPSxJGsJSdbSY7wRuIOB1GaNzC6+smTxeEXyR8YiZp1LyRWjGfLZXFmdzcd/KPvzXjBODfD/p
	m5Qn3Y0s/nXvD3iAuJCh1qDSRGZ/n+e0el2Se+oihqELNXIqQc5fBoMxakvTdf3a3WAzdwKufA=
	=
X-Received: by 2002:a05:7301:5804:b0:33b:e3c8:a757 with SMTP id 5a478bee46e88-342705b865cmr7963326eec.1.1790486259829;
        Sat, 26 Sep 2026 22:17:39 -0700 (PDT)
Received: from FT6N242TWK ([223.181.116.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144173a2asm20713863eec.6.2026.09.26.22.17.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 22:17:39 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	Thomas Maarseveen <maarseveent@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] lib/tests: errseq: add a concurrent check_and_advance test
Date: Sun, 27 Sep 2026 10:47:26 +0530
Message-ID: <20260927051726.71337-3-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260927051726.71337-1-jain.sm@gmail.com>
References: <20260927051726.71337-1-jain.sm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case that races errseq_check_and_advance() on one CPU
against errseq_set() of a different error on another CPU, then records
the first error again and lets a second cursor consume it. The second
-EIO is recorded after the first cursor's check returned, so that
cursor's next check must report an error, whichever way the race with
-ENOSPC went.

Without the previous commit 1-6% of 2 million rounds lose the error
on UML with 4 CPUs (seccomp=on ncpus=4); with it none do. The case is
skipped on a single CPU and stops after 5 seconds.

Assisted-by: LLM
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
Needs the errseq KUnit suite from commit b52f5c1605f2 ("lib/tests: add
KUnit tests for errseq"), which is in mm-nonmm-unstable. The case is
skipped unless the kernel has at least two CPUs (on UML:
--kernel_args seccomp=on --kernel_args ncpus=4).

 lib/tests/errseq_kunit.c | 110 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 105 insertions(+), 5 deletions(-)

diff --git a/lib/tests/errseq_kunit.c b/lib/tests/errseq_kunit.c
index 8f39ebc4a248..5ebc411ea749 100644
--- a/lib/tests/errseq_kunit.c
+++ b/lib/tests/errseq_kunit.c
@@ -2,21 +2,26 @@
 /*
  * KUnit tests for the errseq_t error-tracking infrastructure.
  *
- * These exercise the documented single-threaded semantics of the errseq
- * API (see Documentation/core-api/errseq.rst and lib/errseq.c): error
+ * Most cases exercise the documented single-threaded semantics of the
+ * errseq API (see Documentation/core-api/errseq.rst and lib/errseq.c): error
  * recording and overwriting, the "seen" handoff between errseq_sample()
  * and errseq_check_and_advance(), and the re-reporting of an error that
  * is recorded again after it has been seen.
  *
- * The lockless properties of errseq_t under concurrent updates are
- * outside the scope of these deterministic tests, as is the WARN path
- * for invalid error values.
+ * The WARN path for invalid error values is not tested.  The last case
+ * races errseq_set() against errseq_check_and_advance() on another CPU.
  */
 #include <kunit/test.h>
 
+#include <linux/atomic.h>
+#include <linux/cpumask.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/errseq.h>
+#include <linux/jiffies.h>
+#include <linux/kthread.h>
+#include <linux/random.h>
+#include <linux/sched.h>
 
 /*
  * A zeroed errseq_t is the "no error has ever occurred" epoch: it
@@ -209,6 +214,100 @@ static void errseq_test_two_subscribers_independent(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, errseq_check_and_advance(&eseq, &cursor_b), 0);
 }
 
+/*
+ * errseq_check_and_advance() racing with errseq_set() on another CPU.
+ *
+ * Each round, cursor @f checks an unseen -EIO while another CPU records
+ * -ENOSPC.  Afterwards -EIO is recorded again and cursor @g checks.  The
+ * second -EIO is recorded after @f's check returned, so @f's next check
+ * must report an error, whichever way the race with -ENOSPC went.
+ */
+struct errseq_race {
+	errseq_t eseq;
+	atomic_t go;		/* round the writer should run */
+	atomic_t done;		/* last round the writer completed */
+	unsigned int wdelay;
+};
+
+static void errseq_race_spin(unsigned int n)
+{
+	while (n--)
+		cpu_relax();
+}
+
+static int errseq_race_writer(void *data)
+{
+	struct errseq_race *r = data;
+	int seen = 0;
+
+	while (!kthread_should_stop()) {
+		int round = atomic_read_acquire(&r->go);
+
+		if (round == seen) {
+			cond_resched();
+			continue;
+		}
+		seen = round;
+		errseq_race_spin(READ_ONCE(r->wdelay));
+		errseq_set(&r->eseq, -ENOSPC);
+		atomic_set_release(&r->done, round);
+	}
+	return 0;
+}
+
+#define ERRSEQ_RACE_ROUNDS	2000000
+#define ERRSEQ_RACE_SECONDS	5
+
+static void errseq_test_check_and_advance_race(struct kunit *test)
+{
+	struct errseq_race *r;
+	struct task_struct *writer;
+	unsigned long deadline;
+	int round, unreported = 0, missed = 0;
+
+	if (num_online_cpus() < 2)
+		kunit_skip(test, "needs at least two CPUs");
+
+	r = kunit_kzalloc(test, sizeof(*r), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, r);
+
+	writer = kthread_run(errseq_race_writer, r, "errseq_race");
+	KUNIT_ASSERT_FALSE(test, IS_ERR(writer));
+
+	deadline = jiffies + ERRSEQ_RACE_SECONDS * HZ;
+	for (round = 1; round <= ERRSEQ_RACE_ROUNDS; round++) {
+		errseq_t f = 0, g = 0;
+
+		WRITE_ONCE(r->eseq, 0);
+		errseq_set(&r->eseq, -EIO);
+		WRITE_ONCE(r->wdelay, get_random_u32_below(64));
+		atomic_set_release(&r->go, round);
+
+		errseq_race_spin(get_random_u32_below(64));
+		if (!errseq_check_and_advance(&r->eseq, &f))
+			unreported++;
+
+		while (atomic_read_acquire(&r->done) != round)
+			cond_resched();
+
+		/* Recorded after f's check returned: f must hear about it. */
+		errseq_set(&r->eseq, -EIO);
+		errseq_check_and_advance(&r->eseq, &g);
+		if (!errseq_check_and_advance(&r->eseq, &f))
+			missed++;
+
+		if (time_after(jiffies, deadline))
+			break;
+		if (!(round & 1023))
+			cond_resched();
+	}
+	kthread_stop(writer);
+
+	kunit_info(test, "%d rounds, %d missed errors\n", round - 1, missed);
+	KUNIT_EXPECT_EQ(test, unreported, 0);
+	KUNIT_EXPECT_EQ(test, missed, 0);
+}
+
 static struct kunit_case errseq_test_cases[] = {
 	KUNIT_CASE(errseq_test_zero_epoch_reports_no_error),
 	KUNIT_CASE(errseq_test_set_records_error),
@@ -223,6 +322,7 @@ static struct kunit_case errseq_test_cases[] = {
 	KUNIT_CASE(errseq_test_repeat_error_visible_to_all_cursors),
 	KUNIT_CASE(errseq_test_advance_stable_when_unchanged),
 	KUNIT_CASE(errseq_test_two_subscribers_independent),
+	KUNIT_CASE_SLOW(errseq_test_check_and_advance_race),
 	{}
 };
 
-- 
2.43.0

