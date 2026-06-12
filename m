Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8B3093DD
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249671; cv=none; b=Y79zZ1W7QLg9O+RbOogpUJLxRfObcYchsdq3aGMlYLC7D5ZaUPMKIK4gvqUVLS6T1TpPIKQeV1Bx01ClFBy6hxcciHqQaTbyWTpCifr3mNQbItFbJBDE0KaMLO/VZ0G8wVBevyCHjKfom83QaIm59i3MQDLhORLXGWaoP7eOQLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249671; c=relaxed/simple;
	bh=PsGuPFApl2uLrm2OEy+FMZkFyAqsshOQ6i+w3MfznxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uP3tER/Sv5T2Csfm8cQoButzw56PxpqBiR6rXkLoGTJC88tQsXM0lIGBzj+DmrZ9APQdW+Pmqi9S4uev5PXo0zpBDAPLwvti1U+F0W4Cuy0KHZBW830TXdlzr9g0tPX9uSDw5RcT0M0cYj+bYt8KLkaI0V0yl22VoNwsI+tgfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6Sb4Rqe; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6Sb4Rqe"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso727708a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 00:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249669; x=1781854469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6z2G6Izv8+z2ZU6btEPmjJDYxPH7qSG85DhfG1zhY1k=;
        b=c6Sb4Rqe3J3JNvaVAGrD97peirhUh+C5Iz1UZq5Mux9g6mmOp2vWqAsnUKTVpEhGYa
         0DFo2X+IddzPLYFsyjCyKK56YkpcyYpKuxCpUceq9xMhAHmy/ClfCoNTdUtemR65sQKs
         tkgG8tu+Vofbpy4wNxgqWaJvB0W0R46oIT1eWQNFv49WtK2ZyqSsWBiaF4OO+a43KTM9
         C+AxwxzZRvOSiJBjBjXF1sek7LBsWaBQbSD/rYVFwmrJHPXLrW90isSStI1+2Zgun1BW
         sRRYqT04dmfvQuKWRTLakQJqe6n2CQGtbiKMxvleSVhrvoyOxxNDeJQHitqRZmaKN6yl
         LrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249669; x=1781854469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6z2G6Izv8+z2ZU6btEPmjJDYxPH7qSG85DhfG1zhY1k=;
        b=Ad52w8KASLjyI7tfwxD2Uj1tdZsxWDEgId+aukfJOsM+s1cRRcMO0MywBXucQ4+zCZ
         i3WurR04sgQEeQF0WlnIMrQltZe9JytW0kU9hWNefGHWxa0wms2IRQuYk5PmaQBE39IC
         wD+mIz3jpDXiE5QiuALim1/aw+SEr3u01usKNyZvtpp2rprlzafVcD2uSibdawu8kFu+
         e0j+XB8DJOST/gZ7y8h/FrRi2WOHhL7btrvX/CNILe7oqX0VayUxcw/ZnY2LwxzopasQ
         24HyFERe9MxG9Xoxk6oCv7ekS9G7styf01pGfpmHOe42e8MtXpMPje9uBK1LDutqyiEq
         MZ+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8dW9ns8sphS9WJc7t2IPEqey2DpwQA+BfXY43eKnG01fmethV37zpguyplOVrWk1EK8qJFCNxl/Mf97gxO@vger.kernel.org
X-Gm-Message-State: AOJu0YyqsCCnLu53D4zq4AuhlR5pUTNGex8eX9TW5mQxNOXR3ybKUHlx
	+lP3P1KyjqJCK+l2pRuyyeaWB1P7Xgmbnk4GngAyg3CNfiRxOcvltuD3
X-Gm-Gg: Acq92OEwQmxBX16i5S/tfFyujkU/N4fXtQ3BMS0mDeFfNuU6UihDTxN91dwdcVMAhfB
	MAMGW86gvuDY6vbOYygKnKQxEnfEMSxutVX5TqVQUdrKcgVUh7Ufb2y421TEiI2wO9npegvQx2d
	SnGlsXbWA1UQKBF4pCLa5+obw/3WaewhMO56eVngKbk0Af0xdSKYJ/xF6Ff4h9r1G9oxr9O0elh
	n8VC+NiRrpTJrysJ2k5OlRzl9/WXQJUpOD+Ri6hgoREZ9prWPndkg0bRkTwvqWCPW3pHI+3iH9p
	+ZD3GMTuq92FzWp70EgBgEet/47Hv1t1aU4wyEBa7NBa3dEyTmgrI4z1z9f1Z6ZKM/jOkxXf99T
	TXsgJH3hq6GTNdOpHG8kfmmf3z2WUOsGrdWrqSycSDrr1pC54DfYEVSxYs56CRpgb/xJnVPDKcr
	JeNjkZY+KxhC8US54mwsB41jkHa4Gi1w==
X-Received: by 2002:a17:90b:2b46:b0:36d:bc0d:f78c with SMTP id 98e67ed59e1d1-37a03ccc3dfmr1911861a91.21.1781249669506;
        Fri, 12 Jun 2026 00:34:29 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05d7d7sm1374014b3a.60.2026.06.12.00.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:34:29 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] docs/fs/ntfs: add mount options to support Windows native symbolic links
Date: Fri, 12 Jun 2026 16:33:37 +0900
Message-ID: <20260612-topic-symlink-v1-7-cc1ebf9528e1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612-topic-symlink-v1-0-cc1ebf9528e1@gmail.com>
References: <20260612-topic-symlink-v1-0-cc1ebf9528e1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=PsGuPFApl2uLrm2OEy+FMZkFyAqsshOQ6i+w3MfznxQ=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqK7XwXV+llTaY7YRVCNTk6Meab+Qkhq2M4DzDC
 VGPStZtjHqJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCaiu18AAKCRA08jD6945I
 06iwD/9USiShiFkyO6/bE6TYL3FZrcSTAwKJaAPlTB5TRpjTTtF2Yixg/hcEZDPGqmCZMJu47lZ
 qEcKtH1hdofCHNrYtSrU4uDrgvQih5jJSScPjawnriW8/1EPTAc05J2l6Psz6QP631f34H5k5Lw
 9H3f9QijXAYv2bZwLvaVLyvF/gz75iJeUWSnBtIAhbBG+c0o234XkHEA33RLIWtGCI3tZo3pPSh
 6IR0Ty0iUS7fvydKAhXbL2jWlXWDp+o//tUoWOSRN0NoGoIX7WQKt8FDKSu8wCCKtoyv8kkv+1C
 5Y0NQ/c3zMn/hzGCj0xHpG7XFbvf+D5RuMPdgARY5Dm30g7IkTqHl5xD38QkPNMsTs4rJeglDdj
 PwZsGH51pNuHFBNFh/kDFVNOebWqdqihgyQEddlKJb9lQMpUFuQk6kJAvsxbyfzVYcMiIx65aCw
 vWvnZ3YiaciOyoZ4fizSt7Kcm9hOQTJGY1egg6xMzy+Y9CdX7oc8hIMrgCsJkd0TDiVPfUgECVS
 KJ982+KyKNkaiA90VFo/gxhgA9+oM9j88GU4d04lTElk2hv1wP4EmaxKQqDlvTJD3s3FWo1Tcef
 9NF+dGol1y+Qe0OOyUvAvCYYiLUgMglu6jISxGd9L/z1PBkVGFwn+VJO/gyFD0tybHZ7cPOvZNb AdowlRm5l6+JTuA==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

Introduce the "symlink=<value>" and the "native_symlink=<value>" mount
options to configure the creation behavior of symbolic links and support
creating Windows native symbolic links (reparse points with the
IO_REPARSE_TAG_SYMLINK tag).

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 Documentation/filesystems/ntfs.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/filesystems/ntfs.rst b/Documentation/filesystems/ntfs.rst
index 5c96b04a4d7a..4bfa392daec6 100644
--- a/Documentation/filesystems/ntfs.rst
+++ b/Documentation/filesystems/ntfs.rst
@@ -156,4 +156,17 @@ windows_names=<BOOL>    Refuse creation/rename of files with characters or
 discard=<BOOL>          Issue block device discard for clusters freed on
                         file deletion/truncation to inform underlying
                         storage.
+
+native_symlink=raw|rel  Configure how absolute symbolic links and mount
+                        points (junctions) are handled. Under "raw"
+                        (default), the absolute target path is returned
+                        as-is without translation. Under "rel", it is
+                        rewritten as a relative path anchored at
+                        the volume root.
+
+symlink=wsl|native      Configure how symbolic links are created. Under
+                        "wsl" (default), WSL (Windows Subsystem for
+                        Linux) compatible symlinks are created. Under
+                        "native", Windows native symbolic links are
+                        created.
 ======================= ====================================================

-- 
2.43.0

