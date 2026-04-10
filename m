Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7823DA5CB
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834590; cv=none; b=Tc7ClxEKGv5aW2Q35/Hv0rzTqtcmuIS0f+tgVlLEdwzZ4xVQsb9D6gUgzNER7dXjGYz34jZHVHdrKtorXyOUvm+ADbth1COM0ee8SOGD9pqq0poLEmKc1dw7Obo962vygg/B4A4mCT4DSNSzRtc4aodhqUw0w4bTxpDL96VONM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834590; c=relaxed/simple;
	bh=9fOtjxl1AVxS9jBd56O8yj9/CPpyk7CwC6NfklDZvac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HO/1HX3ddQWN3MUNdT7actL0fUTShR5+nfdymr3OpZ5PvWJ+oXwI967oouLSBBccLP+EZ93h9CBYOnbxo8BE/mxenPV0ESUWg9f1guP3h8nJSOxhV3rpJQHTHzMe7Kw4sjIOPrzQjuJ70szdiE6mN/NY6e68oTKftLwTfPudKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNylztcQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNylztcQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so20807695e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775834587; x=1776439387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aVuKbWZgxpyNY9aAkEjYJ1rylsyo4JWZ9890RwomJzc=;
        b=MNylztcQg3JEHO0iA/EQuIMoWD5G47f7o386ym+GE7aKB9vY/Khb+KMydvZFFn1zio
         +gcZhYVKNcQrKJNFo+PFT/IN3g9uwJQ6qSfvk9aGf7iLDQLkFjCslyJRB5puqQzkyREg
         mHNf2kKSB+lDLpe7zwAUtfWoaRqq1mvPkHyiiyyJttVBwTERWCEcujNqmcfrmOumcxoM
         YsZ0XLwGKR5lycuB4GoDYAmDojwwKJMHbrOFHSsQjAWDHmR22iNwMsCra3bWqJYMmwpS
         jNTTImKFEpOE7CCW8jkOH3jPMb3Ot8JQOqS2crPvf9XrTHlWG0vYpQHny1gX8v/L1e2X
         xHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775834587; x=1776439387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVuKbWZgxpyNY9aAkEjYJ1rylsyo4JWZ9890RwomJzc=;
        b=IH8+M9Fn9Xn3hepKGLrvQWZj6KnKP57bWNp7BltuZ9l/RPdOkImuMb10UaS/jegRhd
         SQPOPYdLjvuG5FXerSuZRvvzsW+SG6LgPlz4JPYwAuZqoUfD0oB+RZQE8OAJ0KHtmT9I
         hrK/WWUI/NAOCq5VExVepgx3qBQ/QWklwFI1vbt2bJ6y2od9tZYJckFXpmdTqgjWmFa2
         1PshxRFC4jWvD35gc1/OAQ9y3122Wgb3c9oB5J9eQoU4zEniFYskC80UZidtrap64iru
         QZ24UueuB71Voqo4EN09iE99IgBAfO8iWABgK1+dAqIhP6OD/l8RVeNFxzQHMB38bOGe
         TI+g==
X-Gm-Message-State: AOJu0YztYaO1tuivWVbIW9rf1qIKmLX+MVJ2FKHcXjyqLXMPoGR1d5lJ
	UvkHXtHrcvscGz2ZD9Bx7vACFU3zhvf2HzGd7U9CVwgGMCCEpC1OUisSk5cidQ==
X-Gm-Gg: AeBDiessmydMPUQaF9JCnEcH7zxrKJD0juHHd8NyFLVQBeYZ78azWLDYguz2SeSihYj
	piUZPP3DNM46OLPYry3NWYteZ8BQ9hsVueORW3nhqt+T47W7gr1fEB0/MVR5um2DLczgjf+Yd5U
	ZrEMtuJZwi89+qxWMsxqfY/s0fl9+NGsPRZvgULzySJZ1zQpizZTUqsDP566dpY1ZoThIe0Xczc
	CZu4Pcp90NMRikWATW64+LNVZd+zzXDA75uZT5TMKOSorLj5hprU2zKc5VFEF4Tj8OorE93Jaam
	/dHOUIU5nqrkNKUZC0QRPV4EjeiT6cw0t/SAvFu0aSDY97UvGWrLcAKA6R7nNqOqJOTKCWSY1eI
	iFTekwVQg8vRwLvbyIO83E/3az7KT1MkD4CsfYmh/+f8vJsGUertC4rUBZCr/faQvjryFG+Un4y
	HKLJhb7aKQ2zAm09tH2GLJHHDWBAXoWYtOTEz5THoC6Jv1h5sydHlXSBWHrK/bdGW+PotVZmoZQ
	9bnh1/GC7w=
X-Received: by 2002:a05:600c:3b29:b0:486:fbf6:abd4 with SMTP id 5b1f17b1804b1-488d67d24cbmr45720235e9.9.1775834587232;
        Fri, 10 Apr 2026 08:23:07 -0700 (PDT)
Received: from corblimey.Home ([2a02:c7c:37d6:c100:60ca:408d:517a:4a96])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488d5d70891sm24978625e9.2.2026.04.10.08.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:23:06 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH 05/10] Add support for VMUFAT filesystem (resend)
Date: Fri, 10 Apr 2026 16:22:15 +0100
Message-ID: <20260410152214.309696-2-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Contents of a new fs/vmufat/Kconfig file that describes reasons to, or not to, include VMUFAT in the build.

Missing "signed-off-by" line added for resend.

Create a new fs/vmufat/Makefile

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>

---


--- /dev/null
+++ b/fs/vmufat/Kconfig
@@ -0,0 +1,14 @@
+config VMUFAT_FS
+	tristate "Dreamcast VMU FAT filesystem"
+	depends on BLOCK
+	help
+	  This implements the simple FAT type filesystem found on SEGA
+	  Dreamcast visual memory units.
+
+	  Dreamcast users who want to mount their VMUs to view the native
+	  filesystem will say 'Y' here. The filesystem is hardware independent
+	  but is not recommended for use in other circumstances, so just about
+	  everyone else should say 'N'.
+
+	  To compile this as a module say 'M' here. The module will be called
+	  vmufat.
diff --git a/fs/vmufat/Makefile b/fs/vmufat/Makefile
new file mode 100644
index 000000000000..da423b0c7eec
