Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780479;
	b=d4qheJNeRBta2zq77LyLKWuiiPWfWcRszDBPlljrBzwNTrnqyxET9bGEnLN560XERnOU
	 1SsCLqvCLtnnT2MkIrOdIkkZlAIFKq/ZomjqJlGWJthV2AVsMrXeFkBmyc9OfOYjVmjdT
	 kyAYcB3s2UXxORlG1xov8d8GxEmYbe1puzXx1yfIW7jvaMy61rxsUy12QK6k3JXs2cp74
	 LYOjTl/w0zp4huticQ0+RZAacSCURJlJtdhLFspciyWNM8VVqMojSW06hX650luI/dPwG
	 ed38s4RSSCbS494KFMs3sraYyOn0Z7EDDbAmFfF7im4/tW3C8qQoNC7z0cMvdEZ9RGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=75mO7UG1vq+0X8jAgs1gX8uFdOb25/StouuKNbz6JpE=;
	b=roZfHJ4wLkz1FJhpPxz0aajRmX0g7HBTWY0w1h5kwlQK9EGgFIgyNsYDT2FGthQttHTN
	 WafupFXPaOyRtKRZpkMom4P/a0SOFYRkutzicfRy+7R8qPGeLqWBR0kabzFiJSzTnqJTX
	 SD92NpeU7Dzd3mgOMec0+JLhFIa0YFQbJfkEPVDiBJhAAXjmih8nVvM784KlfDjGvl9/p
	 /IMQtM51v8kLruv96wIxim4+cGvqu/4Faszt8Kbhih/VEU72L9pBB6M4qptbnf611bNdv
	 +/Oir1Qp0iqE07I0Fq3BpNyYbvCbOfXVSLmWZqO0B2Ffzsr7Jefdfsa711ugUzeyYJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KTjbPWgY;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45893606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 18:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45893606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KTjbPWgY
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a214af2076so7088545e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 11:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792780478; x=1793385278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=75mO7UG1vq+0X8jAgs1gX8uFdOb25/StouuKNbz6JpE=;
        b=KTjbPWgYAawsd7VLvnr57xCEXN4cQkVOrYV5Ymkgp5sgasW5Ulc9IxJpX3cDHDMs3m
         o7w7+OJz2PUuV5BqKOisJR28/mtmTua1uahZBlUQFhmHYjgou12MUfgx/tDHt5JeCWg9
         tYwtmoEpjuhVauVRqSOF0xEHUEuPQpyWD3E8Gep3JJUHD3B3rtjzxt2bDrkmWn7grpcr
         R6hlfE8Dy19iXgG0nKWYXng8pRnMNrTO+98CFmLTufK+sQaD56lWquCmtk/8c+zUH4VY
         WEHAONY0QbrHEW5WWjAnU/cwkYP9y0ANIypygetbm7PmatQ7hJjKhWgMpG31XKRZWbrl
         eS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792780478; x=1793385278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=75mO7UG1vq+0X8jAgs1gX8uFdOb25/StouuKNbz6JpE=;
        b=T/8KEcJp5kCsmoNRwVFsCgj/Zm1KLcDFcIUVStH/ngI+rjqmSOmpd3qZauqOn/6VfU
         +y/H4jeIm2zpM3FGPHShdAHa7XvPP/9Kfo420laAJvZrmATu0Xc2i55EaSUhT7nBb3cO
         ALfQk3ePZxzjxo3ZLlQhiHZ0sNcJlxVpcZclzHs7fMVvsWFtri3j3S5SJTmDGFZyNZTa
         ozLdxscFeeSz8u0QEFSvYgUBWq/A4dLjJ3glcVAoeUH6kD+F2eBtLWaw5bXtGn+fbU2R
         lEWPvLyLA0krikDymHJKbt+NzpMa/3AJTgflPz7+82/BdtUOTVlDdk3txgOHCO3B4UaM
         aJlw==
X-Gm-Message-State: AFq9FYKunliWENIdmX53TpYQ1gA30YLbLlVb8OEFsDrx2mHbt/8V9ric
	oPQIFIQxKm+rQOaoK5Regq72NLwe6MqETrpgsFkjYuf/FitzRV1fCDfYNuVuTQ==
X-Gm-Gg: AYBFou12GlthgmYPpO8b3fzDEb86ftGJsL6kNzU0Ty/WxZzKpG9syzL5m8uG9hJDSsX
	pLrspQ2p2u3+P2tejr4zU+R6NkIk55ekQWUNoBQveh4eOoPFRWbRtHlNYdU43OGqpW/gqJuPyqr
	iQtfItK1aRv3nrt1NXePRfxP5lsU4AK7iSgvIVW6S8WRay0Z7WkV8uKIqwFc+IUmXARlL840ZgR
	1z7PKZFdV/76uNd+XNy4Chb9kqD1HWQhhR3LnFkkdiQoMUczxHSltWKeU2q8wj/HNVk2wYCszCt
	fTuXLtZxx9r163SPFM5/Q1FCAGI4B8T4K54xPc6IwJhvQDJVnHLcnsVwJ1owxRjccNgh+WFldPY
	PvH9zhyYgna/cmhI7VM+E7Y6VLlNKbG7l4yoEhm2tmDXFdyqUwINl8F2Cr6Y6t3t+6yk5AVzG1K
	fTCWl5bTi/LFdRC8mGyJWSB/BlGNTDKZEN3BLw9jsjcV+0pYXViWmEECKkzSCztMvxfcpCTi8+e
	CSrkZQBKdEfxgfiamVOsLXhcBZeh7If30GdZHDoSlHJbf5KXRSmFgRdq7nglkDyhhyp5mrbWOrf
	eV0RVYAfpVlgE5edZDxBim7s0Xvt
X-Received: by 2002:a05:600c:4f90:b0:4a2:1a:a11d with SMTP id 5b1f17b1804b1-4a211bb82ecmr57685885e9.0.1792780477504;
        Fri, 23 Oct 2026 11:34:37 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([105.98.0.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a08013esm1084415e9.14.2026.10.23.11.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:34:37 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH] selftests/proc: proc-empty-vm: wait for child's SIGSEGV instead of sleep(1)
Date: Fri, 23 Oct 2026 19:34:33 +0100
Message-ID: <20261023183434.9109-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test had a TODO asking for a reliable way to know when the child's
munmap() has finished, and used sleep(1) in the meantime.

Unmapping the whole address space leaves the child with no code to run,
so it segfaults. Since it is traced, the SIGSEGV stop is reported to
the parent through waitpid(), which is exactly the signal the TODO
wanted. Wait for it there and drop the sleep and the TODO.

The stop is now consumed up front, so SIGKILL the child before the
final reap.

Fixes: 5bc73bb3451b ("proc: test how it holds up with mapping'less process")
Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 24 ++++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index b3f898aab4ab..cf65313a25f5 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -41,6 +41,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <signal.h>
 
 #ifdef __amd64__
 #define TEST_VSYSCALL
@@ -500,13 +501,18 @@ int main(void)
 #endif
 		return EXIT_FAILURE;
 	} else {
-		/*
-		 * TODO find reliable way to signal parent that munmap(2) completed.
-		 * Child can't do it directly because it effectively doesn't exist
-		 * anymore. Looking at child's VM files isn't 100% reliable either:
-		 * due to a bug they may not become empty or empty-like.
-		 */
-		sleep(1);
+		int wstatus;
+		pid_t p;
+
+		for (;;) {
+			p = waitpid(pid, &wstatus, 0);
+			if (p == -1 && errno == EINTR)
+				continue;
+			break;
+		}
+		assert(p == pid);
+		assert(WIFSTOPPED(wstatus));
+		assert(WSTOPSIG(wstatus) == SIGSEGV);
 
 		if (rv == EXIT_SUCCESS) {
 			rv = test_proc_pid_maps(pid);
@@ -525,10 +531,8 @@ int main(void)
 		}
 
 		/* Cut the rope. */
-		int wstatus;
+		kill(pid, SIGKILL);
 		waitpid(pid, &wstatus, 0);
-		assert(WIFSTOPPED(wstatus));
-		assert(WSTOPSIG(wstatus) == SIGSEGV);
 	}
 
 	return rv;
-- 
2.43.0

