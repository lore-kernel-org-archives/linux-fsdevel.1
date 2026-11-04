Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784474;
	b=yYBoBTKkhlA6KPZO/lcql8nZPnwigZ1PqztJ3FSMC84fLIOLChUc1GhPaHO+Qq+ECZyj
	 +R591vCcigMvlf/AuExU6r4z02z2HgRqybT0Ht0EF356anBU5LDmqGctckmcjpe57bxD0
	 Ms1XIKOhc4tPMxXSDSDfU082Tf7MdPeUDNSUqryM9K+yCwkmUhb7SqoQ25Waqy+jqaiyT
	 BjH+MS249rSbX4jX0v9cYmhdjLaUvVlVFl+3GmkML/B28ia2pml+43V2LCJY1FWpx61mF
	 CVZxngJJbESBALkLc0a2de1IjO2HTkRFcKYvhiA+GBpyvj+YcdBOsP6cA7aqSsfgBrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=FbhRWltBxxgl1MFTaTpQhGPLcLRKiwH3PA6H6UKwK3o=;
	b=AjTd/ZaZ1SGfhBEYXHZiLHEdzUHFPpuSKnCO0NmiGT5vtE5Jz6ly5xZL3b9mctBXiDsF
	 r1IRzrk0IjRJjS9afoZ4zfFzoriDtNtn3pfHh8nnmHDHpQSqYAsGbPegi/KiAYoA7ezAB
	 K0n83TEkAvsn/OFdprKL5cP7Bu/BImgdHOw/PY3nNkL5bnR33vyrWaamub/Ju004C34rr
	 SOiheEQAEj0JPw72/oLjG6MwNTEM901DD1HgeHYtZVBuM3tdIYWDpVtyG8yDjhpTKhsOz
	 YBTMC6aelg8GEWc2reQWPRzpsNCx1ogWw+3ohwNbajXiIXIhpKYZNo5CBiP5k/EdE6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vAOMf3Yj;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18C5606A326
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 09:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A18C5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vAOMf3Yj
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36cad25b8b0so669585eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 01:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793784473; x=1794389273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FbhRWltBxxgl1MFTaTpQhGPLcLRKiwH3PA6H6UKwK3o=;
        b=vAOMf3YjiLDwHmLw8A3rGCPSo1NWhME1Mxs3KoaPzTCPlNo4/uQsmONl9NRDO6hqXB
         GXfZQUHDlIn9RfJuamSo8HQ+z05dvPHSY1cT/QmH9jtmzdiMD21/cMhgje1N5AGOODZ5
         9L0lsb3FNPdxNET8TPFShBUyi5rgyWP0U9t6VuR04k2IpNmvIs80H+lKAMrl9qWJGZDu
         cAoVY1q57D51vHRVGcKdP+YNDHA2Redi9ZausgWSa8GU3AyCNhDGCMQkCqUzMRtsCt41
         wXLIKGr3EwGZyEKzkMa8zv2CBxnHYwFPwStwD2//nBpmgpQc4p5pD6JuI7vFqi8C2n4r
         KL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793784473; x=1794389273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FbhRWltBxxgl1MFTaTpQhGPLcLRKiwH3PA6H6UKwK3o=;
        b=akupRBqM1L1Hbmse71iwp73XVY1trcl17UkMUv7IMnyDNG3e3m9gNMibQbz2vD78uf
         xeWsjys2bRttYhAls8vxdD18N93U+ywAE3RbvERMxZQtdUq9kmj90NVXgS7oP+I+ZolV
         0tIg+mq1wMwwES7/RqfGgr3qciyWehiJyyWsTWNkUq/ZOeBQ8UodbmoddiCdhZg9zdAf
         MxbfyBc1TjxNwJSshwGNpaAcCVhDwWvDFq3L6N3veLQwA4Qw8KCmNFgyLsjsTtkfvDs+
         LPjO3yLRrwVKuK5IlRpCZMZAMhj6VbLJXv1dV2jECVObCi+/nFdut/ZBP1anrcNkxsnI
         btCw==
X-Gm-Message-State: APuU4Z84yS6KCMdReTVOUGFVOP9DnFaWclYyoKoYmxav8cgqPEMtE+gi
	CrPIjs3v4Bz7g2KElj7+IwNLUPkr80/tTpccIsQmJXikcg++TSouP24N
X-Gm-Gg: AYBFou1BmFxoHP/OabjwKoHxTolzQD7P4+OCfbrcDmOM3o7eel+i+mBuE/O4hpfhL/z
	0Q5kkPxmaVhQTzM1KtG+eA6I1KsCFTlowYG/78DXtbjmdpknOTyv/ee2Wux7Ha0sHet+xV37lz+
	vrt7oVAe1voQmUGSGd5Wm7XKSUneXTDT4RgLyR5kdHSdCvMCKwD8c1AXUmSCQcpDeas8FCOo0Uo
	3XSAJopzjWRnR/KeWKpCsPq8u/0bRmbSLSVYfp10ECfa1tyoS2U/OTk/f8tXEFGn9O1gKhMWZ/p
	N6/7nL+fdmLf0K88AgcjeqrEPXt6tjUO+PMRC/EUGjPDvU0LXifZik8NsO1AFu3tZxTIN8WR8ef
	JC3rC0YlPaJHIMrGTu8eqgJPvZ0ksrbTH2EasF1E80OD++kFtX6GIpoQS/+2gB38rv+3lFExWAV
	v2miNfYaXF+PQS5Umkx1GBImY+AT5JPLnm+AkTp980jRxSjwzZZca2OddjgFOGs6tbmBNkzV4K7
	X5lVGVmgGPBWX6X9p5POgzWVN0BACHkXgpH2WnANIYGjylJ8dgM91Io8cj5O3GLpU3ax49d2bEg
	lazi/joqcF/U2FsH9zGK8TPFs/j7bgCglBpFe5Kw1Q6MQ63ccI/IcVSNTOfpmVREIYU=
X-Received: by 2002:a05:693c:4154:20b0:35e:f4ac:5f8e with SMTP id 5a478bee46e88-36a420574admr24483113eec.0.1793784472621;
        Wed, 04 Nov 2026 01:27:52 -0800 (PST)
Received: from pranith.org (c-67-164-4-239.hsd1.ca.comcast.net. [67.164.4.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a67edsm5492547eec.8.2026.11.04.01.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:27:51 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] file: Avoid acquire on shared fd table lookups
Date: Wed,  4 Nov 2026 01:27:49 -0800
Message-ID: <20261104092750.2998440-1-bobby.prani@gmail.com>
X-Mailer: git-send-email 2.47.3
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

__fget_light() reads files->count to choose whether it can borrow an
fd without taking a file reference. The current acquire load applies
to both branches. Only the single-owner branch uses the count load
to order its subsequent fd table lookup against a concurrent
close_fd() and put_files_struct(). The shared-table branch obtains a
file reference under RCU instead.

Read the count without an acquire and use
smp_acquire__after_ctrl_dep() on the single-owner branch. The branch
provides the control dependency, and the barrier preserves acquire
ordering before the borrowed fd is read. This removes an acquire
barrier from each shared-table fdget() lookup on arm64.

With two threads sharing an fd table and each performing 10,000 pipe
write/read pairs on separate arm64 cores, performance improves 1.75%.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 fs/file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 4cd40dfa6129..20ab46434abe 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1337,10 +1337,12 @@ static inline struct fd __fget_light(unsigned int fd, fmode_t mask)
 	 * entry combined with the new refcount - otherwise we could
 	 * return a file that is concurrently being freed.
 	 *
-	 * atomic_read_acquire() pairs with atomic_dec_and_test() in
-	 * put_files_struct().
+	 * The acquire on the single-owner path pairs with
+	 * atomic_dec_and_test() in put_files_struct(). The shared-table
+	 * path obtains its own file reference under RCU.
 	 */
-	if (likely(atomic_read_acquire(&files->count) == 1)) {
+	if (likely(atomic_read(&files->count) == 1)) {
+		smp_acquire__after_ctrl_dep();
 		file = files_lookup_fd_raw(files, fd);
 		if (!file || unlikely(file->f_mode & mask))
 			return EMPTY_FD;
-- 
2.47.3

