Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819663;
	b=TPrJbv/TpZB9Ofw8JAQB6+h7iEuObEVt+tLRUeqB7iVk3vad0jZ2hvJkuKjKtzp57qOD
	 y4mOlSduuJD6F/kjd9CRXY/GGI5IPKnV3SCBiZe4s0KkRjQAoaV3OQXb8eV2mWHZsZxQV
	 Zc8csVoi+e1y2MkIGbupT4AN8Wlk6DpBU/qyCxpaQZKhdj6WlSXmC8UDnUMSQYBc8llxF
	 MzPPhKTej5NR//0xGMyZHQneAbV/gCScic46Rrv2S4k4q7/XqtIZn7e5gg7zmOxfaR0X5
	 ktQZ9l7g0t834AyXEBf5VlbrMouQq4qi9INJ2rxwFGW5t3+oTjSHRmISWvavBww2DjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xITUvna++NkI/eBI/dmyMX8RAsKhHBfiqDAe3Yile2E=;
	b=GYi35PReifmr250H5ipiHsOS2uk26qbU5U4vM9IkMop4IPaadrFatcPP0UNH/+I274/L
	 Z9l8VGpb71zbZBp4BUAZENv2kiqZkrDUaI8m55vDgs0mqUxUEu9LIfb9c5/VhoIxevHtE
	 LBIbpjIqFJ6/T49t2MtVDHAJkiS5qCUhxhHM2hbSw/oFsJZ4uvnESSFbknjp54yiI7+UH
	 kJss89bMaez54whEjP8bevAghu7nyVmgdL0wKGIBiAONiCgsOiXpjHhWstxKYe61wSFvK
	 N3UrcNvxIwM58tRv912ZXGQcxC6Apn52ZGF3fxCRzD0aLsz6DXH2QQXbehWmLX5BBfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcfxRMy1;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A700F606A328
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 19:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A700F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcfxRMy1
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36c9b5c6faaso493842eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 11:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793819662; x=1794424462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xITUvna++NkI/eBI/dmyMX8RAsKhHBfiqDAe3Yile2E=;
        b=qcfxRMy1w09RryqXTW51hmWDlaOIQBBSRpMLN9d1F9lfCHcDP3GnDWzmpdHNb/1tvw
         BBIvcndRsf9hqsfhSYOHR4TiJD2P4WEPRTp8YaG41eKfG2CReL5Up1YXdLXRlEGkMKMs
         E0NAcm8YmnUKi2eln6RQ3TuOCrQai+bY20NLZJvtILd7aGT9L1+bplWyRIlF0VoIJGOg
         qqso8LaJ9LCKdOOnmDlHV45q8u5VMF5DYUQ1EEwMIjpR0MY0hL/4/AqwZr8MWplcfvvk
         bItWFr7ZjDZGig92HszanKDHuyAqv/NByHnN6ke7EqNlgrWC4OfGvek2DA7is7yjOtWa
         kQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819662; x=1794424462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xITUvna++NkI/eBI/dmyMX8RAsKhHBfiqDAe3Yile2E=;
        b=um62c4HO04g8FY5xbbqJLWqjVUPGfRlzNzMADaHWNE3EkyUeN4OKkur8vSHepJlkOR
         OUgHSNW4TJNOjIDpWftwn60n2/1PlzD1/vxgkWX1ri9Pp0dBGKno5gKXGB5i7GosYHZO
         ZfxHuepJ/DsiGJHNHOFxauWi6ZLeZVRafhqLE6KW13eETi9zQfn6VdGhsKbB5XODSPvB
         bt5GQyO/Le3gynm8cuXbDLGTN3rCYBKLBXAJ70aEYa5WJRmJVGHt1W7Qk1HUX/ymoZ6t
         oQLdRH+AfAvQYHvpmf924dnYQMh6qHbTrZ2JDM719dI8FmcYroV/ljo7pN+teUCDK9oV
         p9QA==
X-Forwarded-Encrypted: i=1; AKwUvBwq4DS99tLDBFs7DLJuk9I1OEDZGOXeGu/RSt+FHu8dR218OQqDKXdRNICnmlfFVDj3NKokU/iUbyOcEPhK@vger.kernel.org
X-Gm-Message-State: APuU4Z8gc7Kr7AnDbk3qNmncGlzZdg70G5uSKTd4/DJiBFHHHPTKEYYh
	eetfZNVFX+MghLl90N6HRjpw/V53Aj8nEHjGtT/lq8I4+t80n2ipKdvn
X-Gm-Gg: AYBFou0mlRqUzJ9pmHOIJoyksPnyOMG2muPyHwgwS/7TpEDNdrwSDr1pPJaKsHfmVvn
	QAHVxEnr450PG2I/A43ejItyz79y0xmXvtHGA5uJMoiSvNB6wMMBHuteh+NIkecO52T/q7Csg/z
	Ru8o7yg3VmUUO+aYcu1ePremrJ7+QFOHpIvRsa1ZMLmsBEQo43OmwKOdM+qqNR/7fuMaqyJtccT
	xJB/ZVpCJreqenarKJ4kh6UhCtbeiQ5idlLZyvu51Z7kYWfnR9kitwEHYK1aCcWxid6F+7rzFcQ
	r+AlqV6txoT1IXB7LrwCPc7NP5J8rnAcXhQyUlg9aJFz/aMEU4Ji+i3pK6qDehyZVdsv2RbKGBN
	PEFpYlX/Lj7s+VecmMZ6BYHHFx2nyvbF7WBCne93p2kW9vhXBZbI4Wd0AGsAXijNzUCfuleyjBn
	mniCdXnysEjPH+nXOrUZeNwZYyI+kMTklGZUvqJZycHyMq2VQP3BCYrn1dbWq2iiyJUY76X5ulX
	wYM5y6PplmJG4qfkIgTruYcH5rhXbqp9wYkLjdzbCXctt9mCnr2eUHnz1SSfqazBWHy9S0E8MtK
	S+9UBzcRjUn27DhOQCoTiqKoeu4LZcCFuzA+/VBJPyrSbLFKQz3OWXbU0PVdZX5DjMXLHpvfZI0
	w76vNrGpHWKBNHYM0jPmzqEV10Dr/wLAoROCtcg==
X-Received: by 2002:a05:693c:8803:20b0:361:6884:78b1 with SMTP id 5a478bee46e88-36a423bf728mr26751356eec.28.1793819661646;
        Wed, 04 Nov 2026 11:14:21 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6d3dsm11367318eec.7.2026.11.04.11.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:14:21 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaharkes@cs.cmu.edu
Cc: coda@cs.cmu.edu,
	codalist@coda.cs.cmu.edu,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] coda: honor the append state of each write
Date: Wed,  4 Nov 2026 19:13:55 +0000
Message-ID: <20261104191355.89544-1-dennylin0707@gmail.com>
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

coda_open() adds O_APPEND to the container file's f_flags after it has
been opened, without updating its cached f_iocb_flags. An O_APPEND write
can therefore overwrite existing data instead of appending. For example,
writing "Z" to a file containing "abc" produces "Zbc" rather than "abcZ".

Pass RWF_APPEND or RWF_NOAPPEND to vfs_iter_write() according to the
incoming IOCB_APPEND state. This also honors changes made with F_SETFL
and per-write append overrides instead of relying on the container's
open-time flags.

Fixes: 164f4064ca81 ("keep iocb_flags() result cached in struct file")
Cc: stable@vger.kernel.org # 6.9+
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/coda/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/coda/file.c b/fs/coda/file.c
index 6ca8bfcb58f2..ae03f0b30d84 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -71,6 +71,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *host_file = cfi->cfi_container;
 	loff_t ki_pos = iocb->ki_pos;
 	size_t count = iov_iter_count(to);
+	rwf_t flags = (iocb->ki_flags & IOCB_APPEND) ? RWF_APPEND : RWF_NOAPPEND;
 	ssize_t ret;
 
 	ret = venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
@@ -80,7 +81,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 		goto finish_write;
 
 	inode_lock(coda_inode);
-	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
+	ret = vfs_iter_write(host_file, to, &iocb->ki_pos, flags);
 	coda_inode->i_size = file_inode(host_file)->i_size;
 	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
 	inode_set_mtime_to_ts(coda_inode, inode_set_ctime_current(coda_inode));

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

