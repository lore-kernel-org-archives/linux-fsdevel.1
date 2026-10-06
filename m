Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991BA38F642
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2026 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324918; cv=none; b=kwHf6QaU2RtjMbUbiq4IDcE9VDw7agdrgq5EJ3t22GKeiEWF9KYzkwOW0LBdDXGI0mJy1GXR8gJAnwizig/LOyyPZeGXWjJVn/IsvnDX4KgvPSbLfmLCAF58y/CADZfH151TzgYMLAUs3V50rrWiGU4k1T0lNaUhrIWvtOJpV2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324918; c=relaxed/simple;
	bh=ghQ/9xt8DgBORrjhLrSEA9dJjEGaqnSP7BZJgTBYASA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSXEYCLOiljNuvE/EFZppnwnzQgDHYTBCq+iMccwx/YtRihcsfYn1G7sZFqKrv5FZpeJdI1qmiAp7G/arJVETZs/VS3rjnLHrPnQv0kpkfTwhBfeozwTgidcrTJBmVkZcQVBkuayvlBaWAVZMU7YxyZq7mBbj3U833OD4fuLD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=EVYTsYy+; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="EVYTsYy+"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6b19e291cc6so913525eaf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 15:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791324915; x=1791929715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3b6Jf8//LXq1nt0lrU3uzCZiYGb3bLhSCGzIPeVAOUA=;
        b=EVYTsYy+IV6MkpLIcZQ/qfzqJgIrzF6XDRBpFNlaX5Yo7wWcvJZ3r1EpY/2bO6J/Ih
         zczCuNOmAnzJj/OoFT7CAMa0lDZe9VwLhoPLEd9uxcwN8kYiHPRgAEsyG+z57o5Ctrsj
         /TnRnSbaCqgwAbBRzFgRWA8s3h/4Ao1JYqyoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324915; x=1791929715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3b6Jf8//LXq1nt0lrU3uzCZiYGb3bLhSCGzIPeVAOUA=;
        b=to3QijqCDXewV0Kv4Fju5k0ZLi9cdnEkxeXe3M8cEpOx7nWq6p+ReZj1wzRVzqs/+3
         5FgsQD+CG01V8gLi2q5nfYL5w3mifN9dGsKgmY6Z4UKvYv0SLBnl6QzceNYtm7pM5G+T
         yRWCdqIyyWwmg8SL/7QxVuDe8vJv0zCcZs0PjHbOM5gy0DvNnKLlAKIgB+1cJl/5jWLp
         4b0KsxtFOzsqHOBjaB7Pwb7YL1nqYpX7x8qTk8682NWVk2dgscmd6ajXA6lh8oemwqnu
         d0OHNClouEkgf5q6djyjr3UOE7uuRCcKWIjLcDw6852h2ha7S8Glh4la7NekBsrAyE8h
         uFcw==
X-Gm-Message-State: AFuF++kQEtmEUqXwVjPqC7PME66LlQ1CwN6RimjFxgeB414Yn9LIz9EH
	d5hdsPyANmpfUjz0v4oW19qlLgujxrxc+KCHrvG3lLOU6dyhDogisFlIEW7H2Fc64Fc=
X-Gm-Gg: AYBFou3fHaUwUamRI9btOr75V2L5TdQsM/lHyX7UuMb42aRjwAjhVxWwQbiR2i/1Se/
	6fKI3s7UKIQsSEEXGKP06gmk2F9rAs8cB487ebLKLRsSw/bQfkZe60RQ2yi8JGY18GsCJEzp+aN
	erIHHsGoeF4Nqtx+fDXyEJDBGUnurh42oBE948KWd6IL66MJ+JedXYREsCwfYLy5SX16Hq9VTFN
	wBGe/JnMNZXtUVD6LdQJneGgKtin/ChxhyGrcrphsPxQw6R7BQt6bBxu+3NnwzHH0glZE3iYYH+
	BJ2hErRdYhtJH/qEz/ZRG3TVZM0ehMVySCJYLBfTDr6wKFbVfRL6d4xlMHkXZHfbOOIrLgkw8y8
	vAtOicOhC8GF2OnFpC5HYm08kWJZPpfLSb96CKYL83Q8pq3Q8TDvMWw7nJb1lBaCLfkkwQtUp9Z
	HLrRtiwZUDvq9YQ20AvWpIboTkbL8WBX4WWGcKGil7FoGhQCtXC2LddEetBqCYgpXgtebHTmiGu
	MwHx4hxuLWxPRT4RzZvcULDbGolf/crKWTzJoSS03ZA8XHTWZhuttouOQnwfJWiTh2Vfi0c8i69
	4rcZ4kZJQw==
X-Received: by 2002:a05:6820:7090:10b0:6d9:8fed:b732 with SMTP id 006d021491bc7-6e7a8bb924dmr455388eaf.56.1791324915076;
        Tue, 06 Oct 2026 15:15:15 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2571cab91sm565412fac.11.2026.10.06.15.15.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 15:15:14 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] exec: snapshot the dentry name before setting task comm
Date: Tue,  6 Oct 2026 15:15:11 -0700
Message-ID: <20261006221511.35798-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For an empty execveat() pathname, begin_new_exec() passes a live dentry
name to __set_task_comm(). RCU keeps the name allocation alive, but does
not prevent a concurrent rename from changing an inline name.

__set_task_comm() measures the source before copying it. If a rename
replaces a long inline name with a shorter one in between, the copy can
include stale slab bytes after the new NUL. The subsequent padding starts
at the old length, leaving those bytes in task->comm. An unprivileged
task can observe the suffix through a count-only syscall tracepoint
filter such as COMM ~ "*pattern*".

Take a dentry name snapshot before setting comm and release it afterwards.
The snapshot retries concurrent renames and either copies the inline name
or holds a reference to an immutable external name. This gives both the
tracepoint and the length/copy sequence a stable source while preserving
the selected executable and the existing comm truncation and padding.

Fixes: 543841d18060 ("exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/exec.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 819643408e6d..34cf557a17f7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1279,19 +1279,16 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	if (bprm->comm_from_dentry) {
 		struct file *comm_file = bprm_identity_file(bprm);
+		struct name_snapshot name;
 
 		/*
-		 * Hold RCU lock to keep the name from being freed behind our back.
-		 * Use acquire semantics to make sure the terminating NUL from
-		 * __d_alloc() is seen.
-		 *
-		 * Note, we're deliberately sloppy here. We don't need to care about
-		 * detecting a concurrent rename and just want a terminated name.
+		 * __set_task_comm() measures the name before copying it. Keep
+		 * a rename from shortening the name and exposing stale bytes
+		 * in the inline name buffer.
 		 */
-		rcu_read_lock();
-		__set_task_comm(me, smp_load_acquire(&comm_file->f_path.dentry->d_name.name),
-				true);
-		rcu_read_unlock();
+		take_dentry_name_snapshot(&name, comm_file->f_path.dentry);
+		__set_task_comm(me, name.name.name, true);
+		release_dentry_name_snapshot(&name);
 	} else {
 		__set_task_comm(me, kbasename(bprm->filename), true);
 	}

base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
-- 
2.53.0

