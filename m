Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61F3B6BF3
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790486258; cv=none; b=GfbDfx0UjdQKJ86G1jzIizuEmmdIwyuUuoAHF1iWIOhgni3JJvvgrCZvyvioLhQUsUYY2r/QcW72wTO9vCLVVA9oWX0ciYbA1J/tapaad+YBLyii95H9OU6thx37l84dI9wx7IGMyLG/i1Ffy+QWrE1Iwq1RwlId1aDDhkXdHEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790486258; c=relaxed/simple;
	bh=Ig7aROGKEsEQt6RxfPoVY1cGotH8x3H0xb/4OWtmlSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjlGr8oDEzrjr+8y+gnAk7BzuZxtHaKi6yWmDh3r9ChOXmauOw6aJVMFDEYEdHddXTzPj8gb/bpELI4pa3eUjPaG+3oqDQK1osubJ/ZYFu3sChX0F3B3WkvVCTm89mavLx20ToGw06rleflGKga80E0PrGpaBP6+1FaR5omd7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMMK7UHQ; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMMK7UHQ"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664c2da6so1565515eec.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 22:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790486256; x=1791091056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=atd05RcHl6jGL9KjOrx+DSWTOCcKDrBfeFwCMtdLU0U=;
        b=rMMK7UHQ5tV1eSZLwoWlG9m8KwVU23sO18vh6OjzTzRj2PBjiwshFb2nTqemVONu/A
         b9wYFdCMPS4ziNcEO0+7xC71XUP8xWe63yDK5XvFIqoNHEOdvqOKMz7YXpCfr+7k12Go
         lIeyYCBHajQXIS33YvMVsP2cFpfElTuDmJMqb2iJlnxkNaG2lja9C06OnK8S2SRu4q9B
         XspJK/iaWm60kQVWOWFqOXPSs1jf2a067EBgqdyoK+cc+flHHJnx0d49e0VZVRa0YcMd
         HA+rGrDVLTgFihhzgcnsH3Y6AhlORWXx/fBnYjV18q5o/FnszzlPy+ojvv3j1i8t5ZDU
         IEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790486256; x=1791091056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=atd05RcHl6jGL9KjOrx+DSWTOCcKDrBfeFwCMtdLU0U=;
        b=xX0mINFDWdO3Uc5jiyJA75FuIer5zkiNkI7QXEFeDQ3zd9De0b4qpSx0AVYT5Kje5Z
         jqQGgcbA0YGLugtYTC02N+aKV/nsjJaO1lFXcUUKiJd9HNyaws2uN2yFLqNoyRC/gvL/
         e+yV+smSeFtFzWiuiwsrmxtUVTTgpHTo7Qau93PSKQekcZlYfSQKWGv99b7WII9rYSG4
         L1lNa2SrMc4Ypi2HfQvuu7wf/37AcvjtJ6gr0eh610KsuESYxqJgnpAw90DsEAn2T02K
         9O8ao2FEV59OsU01aufGH82ForCGboFqtocoq77tlviD4vK4nhs8aobFUDzIULyxXbB4
         J/jA==
X-Forwarded-Encrypted: i=1; AKwUvBylfjBUrgHzfHIy/ermr2KbCwElCGUKDzqvjQ954DJkpDNikEuNB9Hj0L5LS+ReBV3VFxn1wBw6fKwiI/tM@vger.kernel.org
X-Gm-Message-State: AFq9FYKm5hvA4m2gG5E+QkmVlpn3qqBHz6jW4rKb9ucDApyIG3GSarIs
	aweqtKMIvDrZzy6zNxK4Cu+Ld8MRXxLht2YI02UdpYcXrIn9z2wB+q1X
X-Gm-Gg: AYBFou0sCYldXX/cDTKh3xi18O0Fnyv85gA32jLggHKOEbTajFv08FgS5yaE74wpnyq
	geURi8f3T2FsSEcK779ONn6XavF9b+rY3t6BJ/oLFQA/utsi0KBEROXsze1V5RhLV3gmdFme2s0
	zcQbqQ9MMpJ5LDfcgcpQTx74dzFKKj2RR4ex4rTrQVFoW5FFcTiS2Ok4QoXTIy5aH6CwZ0GGuUp
	UVFzrwBKfGtsgm5VpW/I1owgSUrr7Q6joBMvAsB0iF5lLV9dMeGKlZKWenBd5e9365JaMZSuOGD
	30WWKDGgEAIw/c/UwVXNc6Lsvhp5+Z1Jh6aVqDdE+bj28JfK6pJ2/fv8H6S/wEBlUHthidOknik
	TnMdOCg5sOAGt8dtA8hc8H7/DKv05Wlf9EwgdP2Y5iUzgVLEzT+2ydnZZslDSuwJtMB5qvJYqF8
	Am4N8HcEeOjtGJ2ZkKGj7BQ8qjZWm3V7ge5H3qbYNLwAnZQifRNpG+dQG0aVN2nApdOEkBK41WX
	e/catbq+SR75F0AahLLKhQGslG6VkMxqCMCi5aYm82ct7LvvabZf3zAlZn493h/y+EBs/BiCtKd
	vxOnyo6BSeAj/VQXX0TFywQ/kaGV8Q8T0bZ/K8zVqmliPNsSRAdmWoBhFdq9v3TUz4riS/BjMQ=
	=
X-Received: by 2002:a05:7301:1f15:b0:341:5da1:7851 with SMTP id 5a478bee46e88-342703b8346mr7214509eec.12.1790486256414;
        Sat, 26 Sep 2026 22:17:36 -0700 (PDT)
Received: from FT6N242TWK ([223.181.116.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144173a2asm20713863eec.6.2026.09.26.22.17.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 22:17:35 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	Thomas Maarseveen <maarseveent@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] errseq: don't let errseq_check_and_advance() hide later errors
Date: Sun, 27 Sep 2026 10:47:25 +0530
Message-ID: <20260927051726.71337-2-jain.sm@gmail.com>
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

errseq_check_and_advance() reads the errseq_t, sets ERRSEQ_SEEN with a
cmpxchg() and then advances *since to the value it computed, ignoring
whether the cmpxchg() succeeded. When it fails because errseq_set()
recorded a different error in the meantime, *since ends up holding a
value that was never stored in the errseq_t.

errseq_set() only bumps the counter when ERRSEQ_SEEN is set. So as long
as nobody has seen the new error, recording the original errno again
recreates exactly the old value, and once another subscriber marks it
seen, it is equal to the stale *since. The next check through that
cursor then reports nothing, although -ENOSPC was recorded after the
value that check reported, and -EIO was recorded again after it
returned:

  cursor f                writeback              cursor g
  --------                ---------              --------
                          set(-EIO)
  check_and_advance(&f)
    old = [c, EIO]
                          set(-ENOSPC)
                          -> [c, ENOSPC]
    cmpxchg() fails
    f = [c, EIO, SEEN]
    returns -EIO
                          set(-EIO)
                          -> [c, EIO]
                          (no bump: unseen)
                                                 check_and_advance(&g)
                                                 -> [c, EIO, SEEN]
                                                 returns -EIO
  check_and_advance(&f)
    [c, EIO, SEEN] == f
    returns 0             <- -ENOSPC and the second -EIO are lost

For file->f_wb_err this means that fsync() on one descriptor can return
0 although writeback failed after the previous fsync() on that
descriptor returned, when writeback errors race with fsync() on another
descriptor of the same file. The same applies to syncfs() through
sb->s_wb_err, which every file on the filesystem shares, and to the
ext4 and jbd2 cursors on the block device mapping. The kernel-doc
promises "Negative errno if one has been stored, or 0 if no new error
has occurred".

Retry with the value found when the cmpxchg() fails, so that *since is
only ever advanced to a value that was actually stored with ERRSEQ_SEEN
set. Every later errseq_set() then has to bump the counter, and the
error is reported. The retry loop terminates because each iteration
needs a concurrent update, like the loop in errseq_set().

A TLA+ model of errseq_set() and errseq_check_and_advance(), checked
with the TLC model checker, finds the lost error with the current code;
with this change TLC checks that an error recorded after a check
returned is always reported by the next check (exhaustively for two
subscribers with three checks each, and one writer recording four
errors or two writers recording two each). The KUnit race test added
in the next patch misses the error in 1-6% of 2 million rounds on
4-CPU UML before this change (depending on host load), and in none
after it.

Fixes: 84cbadadc6ea ("lib: add errseq_t type and infrastructure for handling it")
Cc: stable@vger.kernel.org
Assisted-by: LLM TLC
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
Found with a TLA+ model of lib/errseq.c checked with TLC; the fix, the
test and the changelogs were drafted with an LLM assistant (Claude
Code, Claude Opus 5.5).

Tested: the KUnit case in patch 2 on UML x86_64 with 4 CPUs (8 runs)
and 2 CPUs, and on UML i386 with 4 CPUs (--kernel_args seccomp=on
--kernel_args ncpus=4): 22k-116k of 2M rounds lose the error before,
0 after; a userspace replay of the unmodified lib/errseq.c with a hook
before the cmpxchg(); TLC (exhaustive for 2 files x 3 checks, 1 writer
x 4 errors or 2 writers x 2 errors); W=1 builds for UML x86_64 and
i386.
Not tested: fsync()/syncfs() on a real failing device, and weakly
ordered hardware (the model is sequentially consistent; the fix adds
no ordering requirements beyond cmpxchg()).

Applies to mainline on its own; see the cover letter for patch 2.

 lib/errseq.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/lib/errseq.c b/lib/errseq.c
index 13a2581c5a87..ea4ff9cc2166 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -162,7 +162,8 @@ EXPORT_SYMBOL(errseq_check);
  * points to. If it does, then just return 0.
  *
  * If it doesn't, then the value has changed. Set the "seen" flag, and try to
- * swap it into place as the new eseq value. Then, set that value as the new
+ * swap it into place as the new eseq value. If the swap fails because the
+ * value changed, retry with the new value. Then, set that value as the new
  * "since" value, and return whatever the error portion is set to.
  *
  * Note that no locking is provided here for concurrent updates to the "since"
@@ -184,24 +185,30 @@ int errseq_check_and_advance(errseq_t *eseq, errseq_t *since)
 	 * to take the lock that protects the "since" value.
 	 */
 	old = READ_ONCE(*eseq);
-	if (old != *since) {
+	while (old != *since) {
 		/*
 		 * Set the flag and try to swap it into place if it has
 		 * changed.
 		 *
-		 * We don't care about the outcome of the swap here. If the
-		 * swap doesn't occur, then it has either been updated by a
-		 * writer who is altering the value in some way (updating
-		 * counter or resetting the error), or another reader who is
-		 * just setting the "seen" flag. Either outcome is OK, and we
-		 * can advance "since" and return an error based on what we
-		 * have.
+		 * If the swap fails, a writer or another reader changed the
+		 * value under us, so retry with the new value.  "since" must
+		 * only ever be set to a value that was stored with the SEEN
+		 * flag: errseq_set() does not bump the counter while the
+		 * flag is clear, so an unstored value could come back later
+		 * and hide the errors that were recorded in the meantime.
 		 */
 		new = old | ERRSEQ_SEEN;
-		if (new != old)
-			cmpxchg(eseq, old, new);
+		if (new != old) {
+			errseq_t cur = cmpxchg(eseq, old, new);
+
+			if (cur != old) {
+				old = cur;
+				continue;
+			}
+		}
 		*since = new;
 		err = -(new & ERRNO_MASK);
+		break;
 	}
 	return err;
 }
-- 
2.43.0

