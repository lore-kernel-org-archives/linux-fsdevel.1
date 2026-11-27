Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769345;
	b=q+WHojE4quPNBTE7ql50fvK2MIHE8Em1BfXQHVpK+Ydzz5oD5RhY7+/7QkHLTNe5VC9X
	 F9/giF0x0WijUa/fMpllAeLj4Ny3/ulIZENJMvzyx47DG+c7bcy+hlNH5JsvuQFwshzND
	 WWSt7TdxVznCnSgHBP/3EwS3QdGb6aUOZV2Sz228soBOAhixWKaXMcFLN25Z8z3yqkewY
	 wgxdPcbMBpTQLXtD35KxBog+BZqqfrchXkkwgM4E9US0hoZ5tTPSd06UgtH3ugFQ/sF4r
	 Cono38oxt+wrkMogY60tTsA5um5vWYcbC5arOtbH6aM/OjXx3MpjQK6o/VkDd5Br2Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bAYchJLtcmu0eim/PzW1trsxh4rvw0msXXKEd2Gvip8=;
	b=sAO16poXfTmAybXsncnHGgVuU73GPIWOoVZ2PG85Zy7rbmzQWMRw8f+MYQRgr0J0ZIp4
	 SHu0nafWpnXI8yc1BAcc74wFHYCgwrCPjlwx8KdCCZVw2U0g3qxcVGr6psgPebNf3l0YW
	 IbBYhXF9RVWX3bpNIpBZJOiS8ZyfUdsh9yE4dD1n6ayCOKq8C/WyWuKcCqaJ+0Med+3zp
	 la+g7spTaTdrgXVOjE060N3Vku4rbDWkBU4snVykpOZP8Cpdb6rbZagtV3c+AQSjcD2AA
	 w2hUSGPpPsz/9pfMAurjWi1gsmKPU9CB5KON83UfD5NRZGJWuQJBx5a65/FtX63NpEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WlKEPsN6;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994960A261B
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 08:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3994960A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WlKEPsN6
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a05b210703so3709176b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 00:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769344; x=1796374144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bAYchJLtcmu0eim/PzW1trsxh4rvw0msXXKEd2Gvip8=;
        b=WlKEPsN6nJuR2Bu+idp8dGyZRPA0dTvBOqw9ir8XHq/esz8TCNoRZzWCCfgiIxWKxp
         mXXhTb4mgFPAmJ8sp/n3uaGPIZlTdUUlT8GNAgQ0qc10P3N3znUKHKbCjnhYkHrnSFMA
         KZfmwQP1fOX2q9RgaM2z9/AZkAI+ooZYTo+YseIwhh1dEoM+2iyn7slWgMt7oHZGSupW
         Un6p8L6PpxlR09mtmrZF+f+jnF3io/Hg3iNG8mdvPe3E1jSgz7Dv1lC124+XkRCNG+ij
         KW/t5SDj27pEBZtsl3D9kx5oQbdoZ1vw+h09IUYJux8VTUw9HDfQcM+6jMHnNpS0eS56
         qvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769344; x=1796374144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bAYchJLtcmu0eim/PzW1trsxh4rvw0msXXKEd2Gvip8=;
        b=Quo9arHbCOV0A04TdtPffbjrkM8sRXLhGhSuVsHp3ZkepHay3aD7bd4R84qyJtuN8C
         XOGItm2xdsASwlB6komcoEmnKOVnZFDZBPX9zBroqI4i5uwSZXft4fUGw+i1IXm2GNig
         52BGBdSuokzJOJIuOZDpTyW0d/BQRafCR8PXVhnEmoPhrKzBVwYfd9hEFBA23B+FDchX
         X3c55bWzI+ropGLG4zJCZCbPXK1Hsz7+XJOQcLOn00u/973GE/GrUrhJBDf5q4kaqeUs
         bLxVQVq4WAxttqrQcaUuEkugeeOzUeVCmwcteqNFHOEmLyZvg4jnbG3HVQdIcKxO/dQy
         w7CQ==
X-Forwarded-Encrypted: i=1; AL+hErEGI8wIm/ak3k6XOrxe2NhbqCrqWoNMJMi+ZeHadEZAEZFUXxPKqh1emgyd7NP329c5zrIvoyYaa3t1Rwns@vger.kernel.org
X-Gm-Message-State: APuU4Z8dB76qqVRUqADdm8bomJpQSlv+FAr2ej+V2grV3YxYoWxdmGc7
	pAvmmOruoPnmJIjHQ3O4vu30CKt84ka2Wo4J75U0ZXdDg7Ap2eIiYU0J
X-Gm-Gg: AZFdTZfAiRhPXhBjQA7Hpxz18oP1ruFS78OBjz3TfkGmjQamPkiE7PXD/AzA7KyP3m1
	F9KFqwJug2MalazTdtFz5omZGzdxP88jTu+p7+tt7gfHfZRdMqKQbQPJrp582s4ioVrUwiWc8BM
	7d7rKkjvi6VmV/aUQEiFVxzC+7BxqEnLSs4gx4GXHtIJV36GXnu3WTLOWWcgC132LfkxL95nvin
	X220upBTI2maC6o7sf+dyITPzVc7GRiP8PoHsLsAjcTlRKnZ+ciY+J/OwxzDXtv508HYkN2lO0A
	Fx/PdA0SpNwOq2obeJMtSsyPbigN7otmtnARarO2yxgGadjOyiKP2JqH15uiSmQVDS3oTmVgM6K
	3DGSt+jEJjsXO+ozPVUCYSeoY1P4AByoQGjM8cNhOoelLz/jXIKH1VG+35+7JHO5GxuUFR9qng4
	EayqkYFGbNz3rYBOwyzdZUODmbI/KHzWQuej1rBnQeZaT3laNRVx90in2EWDijnyqQjgDRfS7uk
	cdIispjXZzc+FHXgA7jp2YLXNeF29T0F77HNVa4Cp25ykzetGm7w1KPS/WOuuTZju5v1tbPNQtg
	Ra3amsrn4uFFK68mx1053iFEfYN6DZiNcTIqsd1oXahzChunOsA5vtMCdhX2FJEL/A5jWUwvoJI
	oiOGKGR6fCrY=
X-Received: by 2002:a05:6a20:db97:b0:3e9:176f:ab86 with SMTP id adf61e73a8af0-4014bc4b23amr26347756637.44.1795769344544;
        Fri, 27 Nov 2026 00:49:04 -0800 (PST)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d0818c1sm12289058a12.30.2026.11.27.00.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:49:04 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jack@suse.cz,
	axboe@kernel.dk,
	tz2294@columbia.edu,
	baohua@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com,
	syzbot+cid5582b8164122eda@syzkaller.appspotmail.com
Subject: [PATCH v6 2/2] f2fs: enable buffered RWF_DONTCACHE
Date: Fri, 27 Nov 2026 16:48:45 +0800
Message-ID: <cfdfaea72b21b8abf58cb250495150d92e73beda.1795746008.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795746008.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com> <cover.1788795700.git.qiwenjie@xiaomi.com> <cover.1795746008.git.qiwenjie@xiaomi.com>
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

Pass FGP_DONTCACHE to f2fs_filemap_get_folio() for
IOCB_DONTCACHE writes and advertise FOP_DONTCACHE.

The address-space write_begin callback is also used by internal
callers that pass a NULL kiocb, including page_symlink(). Check iocb before
inspecting its flags.

Keep the F2FS-specific lookup because write_begin_get_folio() adds
FGP_STABLE, which can deadlock here.

Reported-by: syzbot+cid5582b8164122eda@syzkaller.appspotmail.com
Closes: https://ci.syzbot.org/series/cbb9ded8-1388-4a7b-bfa7-44082b04025b
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes since v5:

- Rebase onto dev, using the existing fgp variable and preserving its
  folio-order handling.

 fs/f2fs/data.c | 3 +++
 fs/f2fs/file.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 37d74afc8b26..f3559c27d44c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -5622,6 +5622,9 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	unsigned int blen;
 	int err = 0;
 
+	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
+		fgp |= FGP_DONTCACHE;
+
 	trace_f2fs_write_begin(inode, pos, len);
 
 	if (!f2fs_is_checkpoint_ready(sbi)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c80dbbe76f8f..571a848c6af5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -6274,6 +6274,6 @@ const struct file_operations f2fs_file_operations = {
 	.splice_read	= f2fs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fadvise	= f2fs_file_fadvise,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 	.setlease	= generic_setlease,
 };
-- 
2.43.0

