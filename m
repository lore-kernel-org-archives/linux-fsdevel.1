Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABEE33121C
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240593; cv=none; b=WAwIeeHmby6OMTAwEuPue3TcRMUMXTplYmCbfkUxXiKjF1g7DFEuIHXDXcjJng2KLkHIrZxXYNbVlCyjfobN9X7Mdmrha83EuKMRPX8z3hTj3nLzavmKRQdFpiiTz8M+KqJLE3ob76nRjvJjDj9MF1zayuCDQVkyUu0sJP1CvK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240593; c=relaxed/simple;
	bh=r39Mt+ANrVo8Nbce/0cqQMUz6OdLFlk+s9jJdmvyYt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZlR6LJO6v+D/q93/ZdispLzAGh7MGZXiuailMMA5cEoTOHlqTKlBsY0wswrjOy3I/3o4gU5mrnIVOiOEq6QTx4G6yJgA96W/Yc6pMTjKoFHXd3B3cDalgy127UXZ1VX3p6PBWhQy9FNYce59FsfzLha40pZPZHhPRA91XbaB8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0TMH9QD; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0TMH9QD"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9483cd614so168295a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 11:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782240591; x=1782845391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dgjDRIkuwemtsHS+Lw2hf5LtPo2akVKj+nFoMASDyFA=;
        b=J0TMH9QDwAlAuXIhySz0g/nLVQYetQ/g4p8ZhB1nknWXHVE5eoTjEt4i44XTnxA1yK
         xdT2A1Yf6l2v/F9M9J799Ba23KGBliSe88tqee+VDYNqCnxX9B+aNN4/h9+ekhLYN81l
         v0muO4aCv77hnW8Q/KLLIFhV2I1a5cAZ1dG5f+a7nJZTaYBE585WHe1Xy/o1/Ub01Zxz
         /J5QBA3Sby0A+2roF5DoYr8UTE0U2JaF5aBXqjJ5TJvsd+Ly1bg8rus3T33VuYkd/0f7
         E4ostdfFCsLrALZ339SRXvecYP+nXIxLTmFjRUQnlN4iahXDMqEb46zr0RUvkIskkyh+
         AeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240591; x=1782845391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgjDRIkuwemtsHS+Lw2hf5LtPo2akVKj+nFoMASDyFA=;
        b=YHKcT6fWP8nOvwN/IQq+24ktXqRLMMF6IjdE/DFDXGsi1H79zv573/lgSd6RXPl1+9
         gz9xeVD+VydM6YD0KxNdfZZK8bySWYtjWQQemXxndCkz3THaPUcOsN50F8JLi7kzbF1H
         HQinsQYZxC+AoQjVn+208aYHgCBiMWb8X/Y7VPebMRHZzAFfR0UkllfGgO4X1+UBokmS
         tlWQTjrjCNyId4ZUIq5/7yqcGafibrPCVJVKCIFDYi+H9/X01ci8ITRPOyboYKUczc0R
         yl+wrldznhmp2eHNen1o8kGWxw5Nio2+9VbEp64VAk2jxPGhugX64C8h0czAt8K4ePwW
         tXeA==
X-Forwarded-Encrypted: i=1; AFNElJ8HlNEexO5F6I3ePYU6UhHZXIhv35KSa8BXkez3gxAGYs+P8/ZwDuG8tc0EOdOAwyyU3rClRxbACbcF1/ob@vger.kernel.org
X-Gm-Message-State: AOJu0YxQiGnZ4B7FBrYy236JcQiAPraFifu7f3/A1YqNi1ftSPrLYv35
	2yJqB/ukxeoZjfZqur+ARu7PCUJSQg6A4qWsLx+BpjOObFL+XjQ2/YPUoM+RsxlfI9U=
X-Gm-Gg: AfdE7ck7m8ybVYD0hfpM/gYYxjlNp6MXNeL1Sv+QKKm2mK3I0TltRQF/FoK7JuQR4k7
	D5iUu2SfZJoyoWNi421SMjwVWPgxgmXH5G3pdnvpU0sKJMo88TUoX7OOaEw6tW1/Bo1lrGfOBm6
	HVxWZZpj1UT3YHSRyeT96SDq20+O/Bv53RhDEe8BvWdL4J3tVwqOM6C+3eQfHRNbUHxDAL6t6wq
	HyZ2wZokfWFU/SOqp2UHG7hstjRPIsXGkzuUDSnGYLfQs9dlH68PgluQcznN4YCrFaf6lsx/qGE
	xspBsx4qtwAf3CmSe3hj6K7bO8fnAzbVrx6Hou6XZ66t7aWNckS6vmzdxfUD9FpkfPKNcMGW9S8
	LSM+AYeuVcvUith9gJ0ISDmPdoVPjWPQxgLrOzk8QewzLCoHDSJ1o3GKcp6L7/JaceKrR1ECA2t
	bkQX6nRvqSexxzEWSibqDwECGG9dBDQpwa
X-Received: by 2002:a05:6830:1209:b0:7e6:441:cb4d with SMTP id 46e09a7af769-7e973fec850mr2233935a34.3.1782240591419;
        Tue, 23 Jun 2026 11:49:51 -0700 (PDT)
Received: from alan-QEMU-Virtual-Machine ([153.67.119.177])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94429a5bdsm10119161a34.22.2026.06.23.11.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 11:49:51 -0700 (PDT)
From: Alan Urmancheev <alan.urman@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	Alan Urmancheev <alan.urman@gmail.com>
Subject: [PATCH] exec: fix off-by-one in binfmt max rewrite depth comment
Date: Tue, 23 Jun 2026 01:23:22 -0400
Message-ID: <20260623052322.74711-1-alan.urman@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loop in exec_binprm() permits depth values 0 through 5, up to 5
successive binfmt rewrites (setting bprm->interpreter) until the 6th
one would fail on depth > 5 and return -ELOOP. The comment claimed 4
levels, which was wrong. Adjusting the code to allow only 4 rewrites
would be breaking userland, so fix the comment and not the code.

Reproducer (a chain of shebanged scripts followed by an ELF binary):

    #!/bin/sh

    tmp=$(mktemp -d)
    echo $tmp
    cd $tmp

    mk () { echo $2 > $1; chmod +x $1; }

    for i in $(seq 4); do
    	mk $i "#!$((i + 1))"
    done

    mk 5 '#!/bin/true'
    ./1 &&
    echo '5 binfmt rewrites OK (1 -> 2 -> 3 -> 4 -> 5 -> /bin/true)'

    mk 5 '#!6'
    mk 6 '#!/bin/true'
    ./1 ||
    echo '6 binfmt rewrites KO (1 -> 2 -> 3 -> 4 -> 5 -> 6 -> /bin/true)'

Signed-off-by: Alan Urmancheev <alan.urman@gmail.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index b92fe7db1..d5993cedc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1717,7 +1717,7 @@ static int exec_binprm(struct linux_binprm *bprm)
 	old_vpid = task_pid_nr_ns(current, task_active_pid_ns(current->parent));
 	rcu_read_unlock();
 
-	/* This allows 4 levels of binfmt rewrites before failing hard. */
+	/* This allows 5 levels of binfmt rewrites before failing hard. */
 	for (depth = 0;; depth++) {
 		struct file *exec;
 		if (depth > 5)
-- 
2.53.0

