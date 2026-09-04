Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02B37754C
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525510; cv=none; b=HJulQOi5RICpkYDbDtGUUJWS18VQlZYSWj0i8LwHTvlJT5xx8Gc0ednrCEKINPk+ig3DYQTVMPnwEq09B/WvkA0RCXyNiaKjKIqHTCGi5HgDz8JBN0tT5gLU8JDL0aVWIDB1GZtJ/lL6EkTcym8BbMuJKpttHZHkl+fnIENa67s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525510; c=relaxed/simple;
	bh=MspK5fxUp3qDwwOcwg+R3Fg3kREBTqpRKFnSPdL3zU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Chtmq7EVTNRnNKlWF860xt531hIDWD4pKe2/XKioxtzd7SxYZRzrCHL/14E2P90O9rXkfkNw6DQV/mdJAqCj0ycZJEw1FRwsef1iLrotvNXjzTDTgETb/3df/bxu1DDPFfGEB+oznq+gbus5vnoUi7JrT+K5ixVfcJU8FYl8Fro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdC+P8Ft; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdC+P8Ft"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c250a2bc3b3so113948566b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 05:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525506; x=1789130306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h4ArunB8CvJN6VYVEl8keeS5whHqaufr7Bqoj62roKI=;
        b=mdC+P8FtrZ2ivjwCxkQck3rN2YPfVc1/m1c9DRAL7LMhlDWYJ36u35a8iVTMSqRJqz
         X9NdV5tAuUcP4Cjp3FGASuBUKEY+iE5MIY3gGw+BnwgjJPRmyH2y9SYDRnsDiw32Zpba
         /s7fq+btRVD9uUeZKklvJDrzi5caekaGsaqJ4lK/6Oylu1yQ9PiyrjPKT7uLyBCXLbCr
         2z+MEi0SPvMp6CO871YmtR3ialzr80vmVxVpb0cn077f4rergc8LpSyPOOVuFkYhexbG
         KeWZqW/aeKL9jvuYjnBuB0rOj0aFrV1Rc8SeiVaMPsv2Hv93VaQ16zd3Ua1HCEGyHDLI
         Eiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525506; x=1789130306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4ArunB8CvJN6VYVEl8keeS5whHqaufr7Bqoj62roKI=;
        b=rNGtF4bghgPlmqL54r5XCmXkyvAxxdxlDieZO3VpC+EmwpMi7nqW3OTiBau8VJ7deq
         2w+7hk1iEqtxnUJmScZhp7aI/Z6b2JbWMcimLZZ3aEdhAVvOwkzdWaI4ESIVCOnijhXE
         549fuHifCfx9IFMSuKNcruYhB1rTzoTx0vdei6gPH+NagKiiSRjyDMGARJD6g2+tcd22
         HNW2fC5uAqZL1Kjspz5BXYRTxt+WhYgIkRXPr9b/aJDwE1m53UdvLuTkV4NgA/ejUuBj
         Szim6qNoZc0y1rSZ8uTw/Xb7IMVNQDmSdrDRo83uK5nsIqq/d64VXXjPp69xX6Gp0k3y
         ARYw==
X-Forwarded-Encrypted: i=1; AKwUvBy/x+Laim2DkNTCbL/VPxKh4K9LYtS05z9E3UopujGQI4rBIGNOnfe/wWLUFgQVvkhu810fhEpvpzLxLqEo@vger.kernel.org
X-Gm-Message-State: AFuF++nfZEzTaBNZml4TQ/jFyJGyNoc4OonWVRZcCCptzJ2vYtZdNrHA
	wU3cCeEnDvEf702e5VVx8h5a7tcAJeMIU55XYj9VjEqjT42bTmt7G/1UPhfmpnc4
X-Gm-Gg: AYBFou3v8FTuBwZRC7PzBen4HA/iZe/zZZXHJtNS6U89GwbA/sImdFccyaqBhyqE1LX
	3JVupROONOigRkXI8zwSe4ivjHj2NqZxO1yNVblcMJrU94nJF56chORseNqZiV3X25oZQLhy1Ii
	aGprL3hmimwKqqcmhxJSXkmVxls7S1S2oKXRUqL/bpvjCjrr2q+ZAqkbOkztZddIrm+42OSTFlD
	xbQNzwws0LRVvLFSATej7IVqpVyIx8+NBXrBRZ00XI2XudqqxbMFteg5ecbb8Ly0gsQHw4OOfbn
	JINg3ckKeTcAzNUW1NKIzO3PswTpD62amUwDm9K9i9Xudn7rXaB27+DsE1zbWzqaHrsKyjXupcR
	5azWT3YQiK0+oPjprzeadus2ZZtPo47ow007eTpN+1Lgc9aI0GXwF1YYkMbM5P92u7ycEvpqtge
	+/byuqY1SRzRgDwTTPjWIALVa2boHxqMHWGQLav2q7ojWF4Oaw3d17SHhKUfhG+o10OScesmDaQ
	baS9L5M
X-Received: by 2002:a17:907:e158:b0:c26:19e3:e98f with SMTP id a640c23a62f3a-c2619e3f039mr71686966b.47.1788525506207;
        Fri, 04 Sep 2026 05:38:26 -0700 (PDT)
Received: from fedora ([109.77.55.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5b371esm104477466b.54.2026.09.04.05.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:38:25 -0700 (PDT)
From: Paul Dolan <paul.dolan.dev@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] selftests/proc: avoid exit() from SIGALRM handler
Date: Fri,  4 Sep 2026 13:37:52 +0100
Message-ID: <20260904123752.157562-1-paul.dolan.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

proc-tid0 uses SIGALRM to stop the test after one second, but the
signal handler calls exit(), which is not async-signal-safe.

Set a sig_atomic_t flag from the handler instead and let the main loop
terminate normally. This also preserves the existing atexit cleanup
that kills the worker child.

Fixes: 0658a0961b0a ("procfs: do not list TID 0 in /proc/<pid>/task")
Signed-off-by: Paul Dolan <paul.dolan.dev@gmail.com>
---
 tools/testing/selftests/proc/proc-tid0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-tid0.c b/tools/testing/selftests/proc/proc-tid0.c
index 58c1d7c90a8e..79d3704b2b33 100644
--- a/tools/testing/selftests/proc/proc-tid0.c
+++ b/tools/testing/selftests/proc/proc-tid0.c
@@ -25,6 +25,8 @@
 
 static pid_t pid = -1;
 
+static volatile sig_atomic_t alarmed;
+
 static void atexit_hook(void)
 {
 	if (pid > 0) {
@@ -39,7 +41,7 @@ static void *f(void *_)
 
 static void sigalrm(int _)
 {
-	exit(0);
+	alarmed = 1;
 }
 
 int main(void)
@@ -62,7 +64,7 @@ int main(void)
 		signal(SIGALRM, sigalrm);
 		alarm(1);
 
-		while (1) {
+		while (!alarmed) {
 			DIR *d = opendir(buf);
 			struct dirent *de;
 			while ((de = readdir(d))) {
-- 
2.55.0

