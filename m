Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779190;
	b=klmlQ6KYF3rlNuxuwSV8SScZoLw9qe9g72FiQkOg6JX1pFT0J32Fe+ljiHi7+06LDq6V
	 DdstRAqAg24VnewI3fyYjCl7TcMTHs1Kt9IokcZTjCrQBcJkJ3hEjqX1YAzL3aUrsC5Ff
	 +xHaaVDS8fMKKHQtJSZ/JQoKAhj+NPiP2uefRwDcXPK5iiJmux8WBYy2aIp3iMIS410ZB
	 E8MdTOMFoYVxyT+xGucCC56jbaqtjmJpApfRmZctL6VPADYGVUsyuN4O9c1pX9Jm3ermd
	 pSDwUCZMKSm6V4A6+DVnpOe1bIDujA5rOHGsNTljTXlXj2jJCjrcAhw37M/SPmui+9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4FoCKLxbV8UZ17k7ny+PDZ4wC8nV8QJxctUdFkqIFLA=;
	b=UKQtu8xQbJWHn6IUDMoyhECx5ScLvlPDarfZabc/CohIrdmeahJ5zbMGW8gBVonVuNNJ
	 NuypcfF79qLdo+LsNnLknGUJ3seACmCtl24ESM0dPFLa1WNawfs6s5UIN5KWhkekGYCzV
	 DPA03VgzG/0QZKu7Oh/9kXXhvHtMAyBW65LCgSMQHsJfYPoK+y/FoP7fxLyAvZ+hxehRU
	 YJCQwShlXxawYksU5Ij9soMd0QBcyP3owRPq8W8TZIlKeQOZj13j4z/nG9AheDUyGwafI
	 id37LqfQDXAcmMTVlLlS83xEdPSfPud+g5Qp81Q8Hyq0rlAUa+rKjhrKNgUkwaPA8xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=JWi7MxIz;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF44606A31B
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 18:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DF44606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=JWi7MxIz
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67989a2f9bfso1148761d50.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 11:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792779188; x=1793383988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4FoCKLxbV8UZ17k7ny+PDZ4wC8nV8QJxctUdFkqIFLA=;
        b=JWi7MxIzEivg/dE0FlI7yoQ64woRjflvy/p66c7W5Hgs5umFzQJ5SAZ6vRNEzZrE1S
         6cHHw/U1I6OTEILgYXEMAmHqHiMh34kuYHCyq/+c3ocWPeXwq3kIqZ1BAG0Y7ThAwxrO
         D+F+CaBrG9OnRahT8d4Pdt8DN8WNgfa2pjZ58O3F2xx1fZXl+RH0JGXLtAByV+4Yj7Cc
         /Dn8qx+mU+3xrhBUKLgEKoUYow2lqxRpyY7xuP11VGLKmMX3lRfrknXf1lYBGU2F5uoh
         4xg+vjidzfbEXZmAz5WxRoYOgVYKzgcj99QfBPVNzJIgXFlaisl80mWPOtxSCkkDN4Nf
         SjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792779188; x=1793383988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4FoCKLxbV8UZ17k7ny+PDZ4wC8nV8QJxctUdFkqIFLA=;
        b=JGVz+4vC8WXGASjejNUZ74Ai2iWJmVDyCQdtd/W9cNsoS+h7rDykttx5bbnLE+q+tp
         yiozZSUXRx3HAB7gBnTnaQu9oke54kZMrnq52L1L0GJ3g0EfS71Ox3uQnu7k6NM8bgTa
         rWp6p8XdcL5HNbtLdPxPwwBLFvQSxfMhYIfn/qQmVYzigFjWItLgvxbtAKui+dzTx8lJ
         GPtz1waNZMjNY1bngJ03NBp9ER68cmhoiL0vgwn6BDZa7e/6xHsz5abV0EGwDKhbUh0F
         0W7jhiZOBl04CD83uPUBnk30R633AQryP1+a+gfYNAOwUkvDaSLC/4wpsyxEbXD6y7Xz
         5nWQ==
X-Forwarded-Encrypted: i=1; AKwUvByVqT3w9gTt6FGnZU8bOnZUVbeCOnqOt2629DE5SKuXsHErnheF2Va0MdC6QiaTxuYV65AqDCyMoTkTAFHA@vger.kernel.org
X-Gm-Message-State: AFq9FYL1fxjIxKXawPU0cY1flGX8Lp9ghW8+55hKbv5Y8OxLMZh8a4fv
	qfyCX5RJKPoVeHnraAK3+RUMyYFvEbQ1GUKLDixXQyUgh5cINI6IbkqnaxNRAa0ENQ==
X-Gm-Gg: AYBFou27iBsGLESTh6TuRXPU0limsTCewHFtL+O1kJiVXIGdfNdHUIzyqfwlBT1Uiz6
	cAnSAeS2XTyrY0XVmAiFs7XyjbmnNSLkErsLVIqB8+WhojP+2RUYg8PMcUB++IG1bz08BF5IvzY
	D0jb6ndju5wJgiyZcwSeElaoqJs+p3XgtlGnY/PMtfD4X+C7BTdDE+0NU2D/bYGRkgZIpfnfhcI
	Y5HGtdgdNSia9l6O20np8uB8DkGDNoY2DgXupQkFM5eALKCRQWtdfjWrUcTIc3HBPc9167B0rYW
	X83H1rg1hoG0QgHiMz8EfiAcosFgITZ0xiY2ME8BWv2mgzSGbBxxkWZcCA1mswCfEL32+5WPKFS
	YXUGaXeePrBx35TRM+jb9B6J9PfE2giSocO4QB3YXtSna8gvK/Ynzs0lrZI3T+Rvg4JAtpzJ8kB
	I4wB1Ia+Uu9rrMTn2y6OecT6QVvwQXPduTMK35h/MYoi4Qya1xc3w0m9lc+Gd8hddHzRRQRaxD0
	TwOWZgTSsgktbbsQLmIeQIfukoQU4rWbRoM/uBRYc392hJP5XxwVS6PiOBZBFBPvJLVPdhWVE8j
	9JNqBUrLMyOxGi82rKu4zWw=
X-Received: by 2002:a05:690e:43c6:b0:676:8cc2:bee5 with SMTP id 956f58d0204a3-67a35c97da1mr1062555d50.85.1792779187892;
        Fri, 23 Oct 2026 11:13:07 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a4263bed4sm341889d50.0.2026.10.23.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:13:07 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	usama.anjum@arm.com,
	avagin@gmail.com,
	mirq-linux@rere.qmqm.pl,
	arnd@arndb.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs/proc/task_mmu: return -ENOTTY for unknown pagemap ioctls
Date: Fri, 23 Oct 2026 14:13:00 -0400
Message-ID: <20261023181300.3366487-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Commit 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and
optionally clear info about PTEs") made do_pagemap_cmd() the ioctl
handler of /proc/<pid>/pagemap.

However, do_pagemap_cmd() returns -EINVAL for every command other than
PAGEMAP_SCAN. Before that commit, pagemap had no ioctl handler, and
the VFS returned -ENOTTY for these commands. As of now, they fail with
EINVAL, so tcgetattr() and isatty() on pagemap report EINVAL instead
of ENOTTY.

The issue can be reproduced with a simple C program:

    #include <fcntl.h>
    #include <stdio.h>
    #include <termios.h>

    int main(void)
    {
            struct termios t;
            int fd = open("/proc/self/pagemap", O_RDONLY);

            if (tcgetattr(fd, &t) < 0)
                    perror("tcgetattr");
            return 0;
    }

Before that commit, the result is:

    tcgetattr: Inappropriate ioctl for device

After that commit, the result is:

    tcgetattr: Invalid argument

This patch will return -ENOIOCTLCMD for unknown commands, as
procfs_procmap_ioctl() in the same file does, so that the VFS turns it
into -ENOTTY.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Unknown commands should fail with ENOTTY: Documentation/driver-api/
ioctl.rst says so and calls -EINVAL wrong, and POSIX requires
tcgetattr() to fail with ENOTTY on a file that is not a terminal.

I found no user space that relies on EINVAL here: Wine and the mm and
kvm selftests only use PAGEMAP_SCAN on pagemap, whose results do not
change, and CRIU and LTP only read the file.

 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5c54aebe2118..92b275dc0d59 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3307,7 +3307,7 @@ static long do_pagemap_cmd(struct file *file, unsigned int cmd,
 		return do_pagemap_scan(mm, arg);
 
 	default:
-		return -EINVAL;
+		return -ENOIOCTLCMD;
 	}
 }
 

base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.53.0

