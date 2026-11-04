Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785800;
	b=Gbn8+lF6slau30RvLrKN1/0QEelREK5pq2fL/ajeOElPl0i8MM2WzU7qq5Fwe9CDLqGj
	 oZwoPMCbtV10lmk4wm8QQYC1rPAOqbUNBkju3TMSbdPmlS8U0tMrE2pH0D2c8SAO4pLyr
	 p4iz1mdMzpbwlk87hjUxLKagRhAPEOb7knBJQzwqkd2wCC7uPNtflczKQLT0u/ktVbYrv
	 H3qx9mtozn5n/MBX3c6Omp5jMlAfBzgKpB9NMGjClorCggWqPw7Jzg/Zm6sqEHy1eK3Dt
	 ZJhc+uHV+uut+6UfuWDvo7zYk8yPlV7hz5bbPyf/k7Tdyj493W9tiNHYaTYJmNTE/WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NcwS9ywJAKNcIxqmkMqTgnwEg0S9L8CF0TElYM20qnI=;
	b=qwOeHclYqwXxevcgrZLp5ROCHm4URgnPWC92fEGg7bQy6KWIId05a+wdAwrGQ/flaJqG
	 nbYS9xq6q3kHbq+uXDPWAPSjIpFFF9RGge1PhVHURDvPu7ali5Lu+7kp42wA3H+BN1o0c
	 VRgvi/HeQIIOtip4TljHYcq+I58HAmp3RnfDaQdK052Bua4tEJNEyM+TvQWSUE4KBhD6s
	 4MkGAgafcc26wrfitSkQEHhqJ+ltvL/XcacTxXYfhnk2yIx/1OKOKgzJLgaLH7B89ek4V
	 9GRXcM/38HpQBlRuV2/DGqwNNmcnyhe6+usxWdvlUI5cewmlrJaaMRV6YprjWZerbQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UZKGO9/d";
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA892606A329
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 09:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA892606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UZKGO9/d
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36d6765756fso107399eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 01:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793785799; x=1794390599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NcwS9ywJAKNcIxqmkMqTgnwEg0S9L8CF0TElYM20qnI=;
        b=UZKGO9/dMBKe1CSgBWWa+swSnCwC8v0WZVEKkhZIddudoNu9Ji77fLBVsMP/i06c8W
         ul6yY75cTmMFg0fheVMo+JwU+pk5hFIXWs2YiWFqddh+jFeNb5ESY3GAGMDzUbP6/cOu
         yYOYZjL6YihH0BVw3jx0dRRhxKDBkOpER01+dG3mepVcpFTt24zUcjxPm72mdp+asc5C
         Qn/0coxGUsnydnCtI4UfW9NoWM+g252YmELNYo1pA1A5wMxeyqWwkKaaP1aZGl10e6wy
         uTHH+y9jOZ2mwPvYU8ZSmsArJVwuQMkLgFmHlJ4mS4MJpKCkBPjyatw0RJbeFYZ/r2dd
         sq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793785799; x=1794390599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NcwS9ywJAKNcIxqmkMqTgnwEg0S9L8CF0TElYM20qnI=;
        b=mBkzZO3/YRna1hGFcHHcLpqC0Du9w0lR88OyZU5cNfk9hHDyihgyS7KEwsMQt5r7VB
         6BdqwoVOjo9jr+19Q7A1PKJsFVQ7HL4802kZ0Ai6cYJHReb57cnLL2MGVaUGoCaQ3luE
         u1htgWWzApuTZjuKt1Lv9iKjFyjWH8yvBckZwmuQEp6VT5y3Qp4dqRiShxJAysRICCN0
         YOdy9BXmubN7NwGC+SvzjK7ZmvcWgiCMZCuEnDAHjzzaEZXWniK5IkNYxprHExfDslzA
         tYStOImQFHsMvMovfV2eKcttfI/0Y3NS5H2c8AgizDW9E47J5kZwbRsuvyt+VGCOuSPE
         4ByQ==
X-Forwarded-Encrypted: i=1; AKwUvByp94Nf9zq/IykzTBh+NKysuekVqKR8RJ8ISIQ2jN9pMTMuAwdcTn0D/2ZZTS78q4HMnaflizTzj+iiPhnz@vger.kernel.org
X-Gm-Message-State: APuU4Z8p3UFWIeh4p8/v3t6Sf8EjHiwbylT8XRf7O4svzgFWXx7Taq+b
	aCMjdYm7Cd0TMJIzFnOp5T4wvEQ0wSirm5bHsXI+VWV5el9If45RXojK
X-Gm-Gg: AYBFou2aWnUWieZmLag4TYZP0Qzw9HDJIL2W8nblcKQdqhwjVEyF4mfGYBAX2bPLeWR
	n3yNe8Zhx054VLQWgznGsEng51EX0eSDWJV2Enp8/Bv7HiPt47T4Vk0V57bPTE96kraHMO2kQG7
	fbDZ1AT9yfRL2zU01LsE9QCAieChUdLiPQFbZdfa3Ke3EbOFnO1fcm2PckNyDatwhxd8FQZtGv6
	oVbEQx57lLzRnoK8HUpKshXGKN77zux8g/V8hUNwuCeCrenDVGVyxic4b+Iuym6k7JVNqJJBIQr
	faOZKvCpPUSsVnTjtdXCt5cFmsZmYHrdtYis/b6xySgSbKdMNvyQg3pp4XqSE2C/jP1MTkzCxJB
	tGqstmOHgnhGMEJwrhvWRRwD5ygulwxpMNvnI8woIGMlqXOl9bb6VMIMHPyT+BQSJ9tKXFJ455j
	YPcom07NXAhDTvVgULGL1Rs57A1FLaKrdZRIkBkfLWxGYwOLrwyMfJ1bzkJ1Ii95SLNT5gPrirI
	3lDzQg6CykdunZaav4cT6yGD5u8n6KxC96/A9rfiUjc8uQobZ9Adb+3T1IP5FcKNc+i3WYYftHN
	HVtJQcXzG0Kze4BkzAqrplNrMNaS25k9xymmovpv9Kd03sdV1XU1GXhqOzJslfQ=
X-Received: by 2002:a05:693c:2512:b0:369:fa7c:aee9 with SMTP id 5a478bee46e88-36a423f54a1mr22508608eec.19.1793785798462;
        Wed, 04 Nov 2026 01:49:58 -0800 (PST)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3989670sm8205216eec.25.2026.11.04.01.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:49:57 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	exfat@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH] exfat: enable buffered RWF_DONTCACHE
Date: Wed,  4 Nov 2026 17:49:51 +0800
Message-ID: <20261104-exfat-dropbehind-v1-3caa58820a82-1-qiwenjie@xiaomi.com>
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

From: Wenjie Qi <qiwenjie@xiaomi.com>

exFAT uses filemap for buffered reads and iomap for buffered writes and
writeback. These paths already handle IOCB_DONTCACHE, including marking
new folios for dropbehind and completing writeback bios in task context
when needed.

Advertise FOP_DONTCACHE so preadv2() and pwritev2() callers can request
that newly instantiated page-cache folios be dropped after I/O. This is
useful for one-pass reads and streaming writes to removable media.

On an NVMe-backed exFAT image with 128-KiB clusters in QEMU with two
vCPUs and 2 GiB RAM, disable KASAN, lockdep and tracing for measurement.
Compare normal and dontcache I/O in three pairs with alternating order.
Read a 4-GiB file using 1-MiB calls. Write new 1-GiB files using 8-KiB
and 1-MiB calls in a memcg with memory.max=255852544 and no swap.
Write throughput includes fdatasync(). Median throughput and peak cgroup
memory were, with percentage changes relative to normal I/O:

                      MiB/s                   Peak memory, MiB
                normal/dontcache  change   normal/dontcache  change
  read,  1 MiB    5788.4/5124.9    -11.5%      1353.3/18.9    -98.6%
  write, 8 KiB    2924.6/3400.9    +16.3%       244.0/106.7   -56.3%
  write, 1 MiB    3534.1/3985.0    +12.8%       244.0/188.3   -22.8%

Dontcache reduced peak memory and recorded no reclaim scans or steals
in any profile. Normal reads and writes scanned and reclaimed about
710,000 and 200,000 pages per run, respectively. The memory-limited
writes gained throughput. Reads reduced peak memory by 98.6%, to just
18.9 MiB, at a modest 11.5% throughput cost. This smaller cache footprint
can help reduce memory pressure on concurrent workloads on
memory-constrained mobile devices.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/exfat/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index db000001c..5b67bbf81 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -1107,6 +1107,7 @@ const struct file_operations exfat_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= exfat_fallocate,
 	.setlease	= generic_setlease,
+	.fop_flags	= FOP_DONTCACHE,
 };
 
 const struct inode_operations exfat_file_inode_operations = {

base-commit: 79130348ec29b74950e925e06c26f1a4eecea5ae
-- 
2.43.0
