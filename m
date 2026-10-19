Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B07455623
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 04:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792383511; cv=none; b=Xocd2mlzZt5hqT/W2UtB1fz0DF9lqMI09GwhGYXaoRV9Oh+PJ80LvLQRR3kMRsplhPPcF0hVUyLa6T5/0zDbfn0Jp769ezhrvZQ6BEWFkHC6Thy3ypkaI5AgiZMx6emGYHlR4uxS/ZUFWHIYBDFRiyIZPxkVy7w+kCh/4ctaTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792383511; c=relaxed/simple;
	bh=7n2GUVavWCaznIULC4koTaKML5uMo1SBp+OgkDs0sgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlHE8eVxg+HPEeyJs5clkPBNbwjbMvGvkOCyGmqt+24hi9ZIg3lTcVw6ElQEoNrVo1BCOIe3qDmEXx/g+yUuJakRuYfaNFd3c7rxiXAYN++uzKXnUWIRxcrMUV7wxd46dd2RxL/NFH7DvmC33ZLxw6xyMPxYT0uN0MgXv7viD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1e03e8004so423435e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 21:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792383505; x=1792988305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P8yTvohyfHN+LGgMhB7OAI4MKDO7ZPXP+V+3d2M470U=;
        b=zCUmz1OwB/VPyETyYcgt0QzY+0PqCe726jGLhaetkYaHGxkEvEob7UFrXdQdzkt79g
         np88jEg2zyhGrgbzZALHFWy9TwR4CC4aSquTF/JOpcR5GCom9xeAuBcfvPctu2iUlAeR
         zhO25wK7X7+OUxA/n3swLwfHy9lXaVegcwkd0tBCuwW1YiWb9YTu+Mrng16OEeBM86Jk
         F5xDWO4xrVJw57SUBJoGQa8nNNuLhk++0C5P4TQEOpnj5lyuYYFO+MH4nIll+q9urF0k
         RV+rCotPmn0FSC9ILEOpSRiJp8qZ35CBzEv/qz4b1sgCmbGdvLA2fj8Jv5hwwxV8tp2W
         ftyg==
X-Gm-Message-State: AFq9FYJEXx2s6lrUmFNiDY0UIA6UTq2v+GtiEUi6OnFIgWG4t6yxKKK6
	7gIDM14XbMzSojQhXEeBPboq7IPV1a7p6wzDX1VFsYqAtQ9HqJEPQpF9
X-Gm-Gg: AYBFou37jfbxBvfl709V85zw6R2D/MFmVVm3hsQKT7gCBrKxZ95xEsBHr9y0NW/iMYd
	DX1Us17MBy5NwW3zXNhKpuUaB4oDh0OLldrDqyIIH2sTN5b3iMJGp0/qz/S8ktVihMktw90NO6Y
	87YosSsPw/up7XxYuO2iev+PRpMKTxeDXmKUXqZzOL96ZkMIVHNvkckN3DlRzi5BApsXWvSnYCd
	5y0tdl4K2LM4SeBLWDhQWEPcXgefWMB27HjqHsahsNpXBB50ItOsCzDMRihici/2qgxO1D4tndM
	qbcen72Rj+ZhtmsllDeTnjJGO6j+r/8PJSn2oP0UHJqBxLGTh/sVYhy6jGOcjJUg1TKdXRrNt6H
	fmaCgAERntSX84oCdYxxheVnCZTRTmZ484Zg3R/LYHQk6x99GHGlh/trOUxjfH7sp46jDNuwGfv
	JUIAhTb9D+/USI5PgfNZMrfzdUcYJkoE4vM+5z2qJVozWlBaOp+5kqyoqo8E+OvcUbg2H+VPB4T
	oO09fCLXWBAAxfFQ0V9DN7v84pcI+lYeNSv
X-Received: by 2002:a05:600c:4ecc:b0:4a1:e015:6441 with SMTP id 5b1f17b1804b1-4a1e0156660mr91288055e9.0.1792383505145;
        Sun, 18 Oct 2026 21:18:25 -0700 (PDT)
Received: from spartian.home ([2a01:cb1c:76:ed00:602f:c5f4:d108:b925])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm20090449f8f.42.2026.10.18.21.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 21:18:23 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: Aurelien DESBRIERES <aurelien@hackers.camp>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	aurelien.desbrieres@gmail.com,
	linux-api@vger.kernel.org
Subject: [RFC PATCH 18/18] MAINTAINERS: add beamfs
Date: Mon, 19 Oct 2026 06:17:28 +0200
Message-ID: <20261019041728.327785-19-aurelien@hackers.camp>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019041728.327785-1-aurelien@hackers.camp>
References: <20261019041728.327785-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for beamfs and its documentation.

Assisted-by: LLM
Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 62744835f86f..e5b95458da43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3082,6 +3082,15 @@ F:	drivers/usb/host/ohci-nxp.c
 F:	drivers/watchdog/pnx4008_wdt.c
 N:	lpc32xx
 
+BEAMFS FILE SYSTEM
+M:	Aurelien DESBRIERES <aurelien@hackers.camp>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+W:	https://github.com/roastercode/beamfs
+F:	Documentation/ABI/testing/sysfs-fs-beamfs
+F:	Documentation/filesystems/beamfs.rst
+F:	fs/beamfs/
+
 LPC32XX DMAMUX SUPPORT
 M:	J.M.B. Downing <jonathan.downing@nautel.com>
 M:	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
-- 
2.55.0

