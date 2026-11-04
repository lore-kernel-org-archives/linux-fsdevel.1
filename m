Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776215;
	b=MakYtLitjPgxKyuxg0BlmTVO2rMMY+HHUuStZHz1pXqTHWxlgrZCw8Gll+/OjAgEGMym
	 LK5pplq/r4/xvMe+wqa3+XaFlM0nCGe5SLNQgaDUMrSCh/DNgF5SBJxacNkFqUcCdMXwA
	 2QYBqvLh1/VbNgilBoR6wuRUA+ttfMRJ3poYBNb4ovNf7n5qwY9071lJ4Kie6w8gR4CO1
	 XD4gUGG+DnORLVlUXUQmWYyE+7NDbohO/IrgZMN3euzcDQAjeo3nNDQenznFQUQrT1IDu
	 sugcdjb8Kq6vJLGCxsz8YKy8aheeJFkqu2cPaiu6Kg90pSh3sX7iPocaCd5C8AmgMmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JhcjK44jzqfwISimpbYLtHkEsfZ2sH/PIN1jlamuBwU=;
	b=fW8ESvljMFENCJ2fFPTbzqX/nIXXnM6UpUG3ioG4iLSPPwpqDMoxzZl+Cbbqv1HmL+cW
	 0WOcDrBqM1iQdX74Cag+PGha/syRh+uFY2gt5nlqxHVxVHLvaWR9X4zlAeisspXlhzqO6
	 k8vcbS431SqIxwQJxQSk7yLlPcJrnhM4ZQB2rkYSZC7JzmaLJ8TPX0daiKpL/A3Bq6g1c
	 8WPZEsS87pIJKQlcQZa0oINjMgDHwp2vy4wPERBrpRNJhBcHRRJexUD/wcUstTKhvhpu9
	 j7bn+4N2+76/Cm2R7WfA0zqLw0NZMpN+upztYHRJhcXFTIAtdmx5hc/TTkahsEGBscg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="p3JF/d5q";
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7A4606A328
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 07:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F7A4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p3JF/d5q
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3adc0ac3566so164104a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 23:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793776214; x=1794381014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhcjK44jzqfwISimpbYLtHkEsfZ2sH/PIN1jlamuBwU=;
        b=p3JF/d5qISNlqFT8OHEBgICb3Nz4rS+wiVeNnS+hQx/BN++8gSH5sfDjH4SDdBMkRB
         P72mhK4HcwoBvvTPGgp4OyotjrneiUBfr+wUwqbOKHlM7+8XXkC+Co2xwWP879/87T2G
         /gO1TwrduiV6PJwI0iTyJSBEvpa+3FSkOWicE668nQljYiTT4rzOmOvMwO0DxMg9GQu+
         FdhZXTa/U6ldQbVuBNJxuueELNJFDRtoVA8jYzKmo0J14558AaK26jhBJd5HT1CwAZDK
         sJeP3IMXZYmPhfrMURq7GME+pP3ANCz171B9Ls2eWpnkb9026KJFtEvVURdySo6YyAg/
         YwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793776214; x=1794381014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhcjK44jzqfwISimpbYLtHkEsfZ2sH/PIN1jlamuBwU=;
        b=idI7ZatAJEjvvbaGMLwGvFSyYKmCi7Wh+u+ZHWN5mCI8GYgYoO2k36uUpOJjtFJ+iS
         91x7abQo6YxghaNPU0cM0u7GTbF6rjjftOxz40WxSj6jVaFrp6L5WijhvZ4lbDgkf8nb
         ue2ayFk2DuA/rxErfTfsAPRZOTpuNXEeh07k3uSYUWshtqEaNwN7GKOw8OBSMpbH3G5M
         l21MGJMHzL4WTsJWWfikERYJqSC2B5QlCeB7s7LcXS6Gh1dlk5kt/xP2chNsFkY5Xz43
         pF01qvSTM0U5tOwyAEWwpClfaO1VHgkaLPLH0SSkCzNetJ/qj3qkETX5EwH4teD1wuVW
         E5MQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcfyRMezXQamPOxbVoTlTfjIOPLJITKPi/sQh71u46l3HPCHRi5aD8PW1ce6OV06MxnChgyDk8tduc61pt@vger.kernel.org
X-Gm-Message-State: APuU4Z8jMCED5aavuaOSBskB+yofNg/7UifVWkDpFGfGBpPBJpo4OZB5
	NghjmOAIKpbZtGQ+/W6LWN0wlkCFpQ5orZ9NSs6MlisyiEI6RbIICbp0CbBY5z3dYcI=
X-Gm-Gg: AYBFou3JaRX21/PQNEnoOq6Q5QufQdPi7Q7OUq4pBWer8WRDJQL9TLW2TQ+6jWLfoYi
	zKp0K39pr6OB1n651XhO78k5LnSLU7Sarstwnu+FDMeloCQ+AySvsbEq141k6AP/ReqbdMdWmej
	1b0P/jup4HAE7hFB6hSlZq2srV1yY5Y8GfSfQjxbEmumTnRMcdC4GeDmYKl7Ff1qdEwlM9r35/o
	cnQabe1b+ZNN5KGbzzBiYNLgwxkYITGVVMCA4zm7/RsCeGMYIpw+gTqFDKMAqeIjAUnqe8Slz+U
	o4mCkX1UtEZ3JACauej/NRbdhrwdHLAPuBQamjQwlWlbgVAZubm8ba/yyH/tGIbyazAWgnSTyAB
	bj05uNjT5buqFMNKMGIUsfQJ+TCuATfsW09EVixFKWsQEFy+da7QNxrKqaOETewDLEpULKo1Av5
	FF/E6hsXATnu5WcEZTJE9uKTTWZUT9uQLng8w4GFrmeOwWkXEylPvgXqMpXnCVIxaU1M/dDgnOx
	+g9FwwVEVX97I2k1yJWtl371goBHv2jCru354EBBYlWMTAqL2iKFdq0Slq+QqF3Y2fs/gEjbY3w
	WBg4u+/iJHNyg4bJGu0+WiHuEwBPHtos1mcAk9glVm0Ei8mQHZeltErUTbN3qhFZpZ5PNoG6hI5
	S5M/3AmTS7buCd2vIIz7Bm9o+H54186v1TaDWMw==
X-Received: by 2002:a17:90b:2547:b0:3ab:9c73:12e with SMTP id 98e67ed59e1d1-3ae89536c0cmr12582654a91.6.1793776214401;
        Tue, 03 Nov 2026 23:10:14 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b093d481a3sm2651997a91.1.2026.11.03.23.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:10:13 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org
Cc: kas@kernel.org,
	dave.hansen@linux.intel.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] filemap: prefault writes starting beyond EOF
Date: Wed,  4 Nov 2026 07:10:02 +0000
Message-ID: <20261104071002.49693-1-dennylin0707@gmail.com>
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

Since prefaulting moved to the slow write path, a buffered write can reach
->write_begin() and ->write_end() before discovering that its source buffer
is unreadable. Several filesystems can extend i_size in these callbacks
even when no data was copied. For example, a one-byte pwrite() at offset
4096 into an empty file can fail with EFAULT but leave a 4096-byte file.

Prefault the source before ->write_begin() when the write position is
beyond EOF, and return EFAULT if no source bytes can be made readable.
Overwrites and appends continue to skip this prefault. Keep the existing
slow-path faulting for forward progress after a failed atomic copy.

This also leaves intentional zero-length ->write_end() calls used by
generic_cont_expand_simple() unchanged. As with the previous prefaulting
behavior, a concurrent userspace unmap can still race with the later copy.

Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
Reported-by: Kiryl Shutsemau <kas@kernel.org>
Closes: https://lore.kernel.org/linux-mm/at9xXRhD2xZhszEj@thinkstation/
Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Link: https://lore.kernel.org/all/at-XtWBQg3jv3H8Z@thinkstation/
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---

 mm/filemap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index b74bc1e5015c6f318333427f223b9f42061a6213..30414d55412b84f11ebe98b8eea607ee8c04eef5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4389,6 +4389,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
+		/*
+		 * Some filesystems can extend i_size even when nothing was copied.
+		 * Prefault writes beyond EOF to catch unreadable source buffers.
+		 */
+		if (unlikely(pos > i_size_read(mapping->host)) &&
+		    fault_in_iov_iter_readable(i, bytes) == bytes) {
+			status = -EFAULT;
+			break;
+		}
+
 		status = a_ops->write_begin(iocb, mapping, pos, bytes,
 						&folio, &fsdata);
 		if (unlikely(status < 0))

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

