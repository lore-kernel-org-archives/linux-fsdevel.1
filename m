Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75943F4B3
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783460335; cv=none; b=HwIyEwYs/ZY3PCv5om5mxAqJr+Q/5MCdXOFhwvxvfNozswTraFyR0pMVzWqrYpASx90m+n4sMG/9BM61DMIZw+oSPJV6vUsyd0oPsEkSN5qyUX4wLm6vv7OrUvlIVqJt7rfDbToYImOt5G64II0snTbtY5pnML3XmMAdYGuP4C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783460335; c=relaxed/simple;
	bh=brot3bU627eibPuK843dIWAZGselX2YxoaJySxQF6fY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PA9HvpM2VW1VIFAndxP3fVnFgYFWr8CaVYgXQt43wK3VjugVS70KjsrM/bIIvKOd5B9PIL9KsG4C4PqqxLkL1+kThhyWzYJ4c3+sd+aTcln6bskqvbDKTxDXOa4yPPqvAywYRiB4LpH8HMAdRINZTrM8TmI3zLZud+3wQJB7jv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3KWzwq9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3KWzwq9"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47122683cf3so17394f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 14:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783460333; x=1784065133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bNwYc1cJ0kqQCz9PMZarBbXYOPfgykvOIERr/DpxJTw=;
        b=E3KWzwq9FyvGUL5wXmhI7BQZspOvg8Awnrhy5AiFELw+YGrrxzC6GRnz1+nHZKLhW1
         n27xQ4j7krISP1hITTvPWYrseSp8LDi2PevxMvzyKHkqSxKXpRalJUOUM4+YpZf65U0R
         FSoYZiQNQcIn5fWQogMPmvKyN5TQ2xodgFBihqbA8ZmbGQHRis5nIfVNghQ6bXuh+ACW
         zKUdFWqp+X9e+rWd2soiKibwUzSV2+NgTyQOJmjRObjMCdgDabRGcrk2K/yoKf2lQh2a
         hqLbwsDGcl1DatapjCoO0kv226jhePz6zNk2HCAMu7M18pCOKke8exfX6zoS83Qm4t6a
         1dAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783460333; x=1784065133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNwYc1cJ0kqQCz9PMZarBbXYOPfgykvOIERr/DpxJTw=;
        b=frnbMak1/49N3Eqv2748zc7VV0XN+edk5V4dadlfUibfppackK7awHjKTWZsH649cp
         2vfb/O26f2y++LXRDeoCoYOk4EK9cnzzB/zygbwbq5onuc5Epkc2kyeA/oEjz0uWGgqu
         yF8DVcapmnX3LgZlFm5LJZb2OhDNaOI5JqrjZr1LN3UeDoGpaOX19oND80v9Jws3Cz/s
         WsRdAQtXZ+AkLusI05mzVuLranTjW05jY07caDb2rfP1wKJWkO2bhfXQuIKmSEG1qWsA
         6eq96VzO2pn+c16ChT9a0zG6gUOam0ecBUXt89pLEvkHULY2PBuPG8UK8TuHtLOh+XCq
         NTfw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/eAPAeg+NVUKUhUPFXtsmCloLpDJEH7h5FSjouC/SyGVK9+1l85N7iukeKggzdGN5LLgDNeeGMbbzTdoX@vger.kernel.org
X-Gm-Message-State: AOJu0YyN2Gh+Roa8XqVrRpsZ3F6AlRaSEa9JruMeC/CNbpUxlOyrCp4/
	xeygb1ywvA96fAk26zoj54oFH+SkzdIBa6h8b0iYOMMrBZpeXyT2bWv9
X-Gm-Gg: AfdE7ckyhSYV6W4A9gPT1Oln+AOFBAMtvfGUk/X9f9AjIyBSmT1v7LJzL+kQEPvU2F3
	uBGgQ02RRAhMrCCEpsWFKJncL3Jk9BmaXF6mcAFjIID+fiw6/ZGha3IfE3O2RdG4Bwhj3ttavAI
	N//H0v0Q7+1skOLgq2WuvphEZVZrqbfSrdoyv9pWF5e4ruvMsu9ZAg+I90hcZC7RLLZOdqIDfOV
	NBS7s3PCmPMEq2ojLjbLszn55Rzycju1Q8w+nBn0CvegxyKdOxi0xO326SvWIVsJJf7q49ju3C9
	iShyCVxV6YZZtkvC1i2e28oZwCvZfJM11yJdHqJQQDnJrefha1l4xuatvtLp94B647D3QfW0tsY
	DQSTeQhYrrJ90+998KmLy/UL5lvYCgO22XjkfKUW6yRUnNJxpGBY4Ne7O5nT1HG+BJUgTTPDXwB
	jJQn479OgTifrrDs/ld5RHRdRI3BLcnKZL6I4X4tKLnGoU7cFQq5B9QZVYkHh8gLxaVu+xGhJ9/
	AqZqH/S9e2odhDYo3djtUV5Mm0Pvs6UYnb49k4yiyRCGeTIWtjzoWQX6SgWxT2CSHUS8VUkRcg=
X-Received: by 2002:a05:6000:461e:b0:47d:df96:c9f4 with SMTP id ffacd0b85a97d-47de6667871mr8403779f8f.10.1783460332789;
        Tue, 07 Jul 2026 14:38:52 -0700 (PDT)
Received: from instance-20260604-012959.europe-west1-b.c.project-2c9d95d2-bf4e-4d5a-ac6.internal (250.69.76.34.bc.googleusercontent.com. [34.76.69.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039bcdasm38086196f8f.21.2026.07.07.14.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 14:38:52 -0700 (PDT)
From: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	George Anthony Vernon <contact@gvernon.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 RESEND] hfs: validate catalog CNIDs before instantiating inodes
Date: Tue,  7 Jul 2026 21:38:34 +0000
Message-ID: <20260707213834.431563-1-davemadmaxxx@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,

Thank you for the review.

Yes, I agree that the initial length validation can be simplified to:

        rec_len = fd->entrylength;
        if (rec_len <= 0 || rec_len > sizeof(rec))
                return -EIO;

I also agree that, for the fixed-size file and directory catalog records,
the checks should require the exact record size:

        rec_len != sizeof(struct hfs_cat_file)

and:

        rec_len != sizeof(struct hfs_cat_dir)

Regarding hfs_write_inode(), I intentionally left it unchanged because
the patch was trying to reject invalid CNIDs at the catalog lookup and
inode-instantiation boundaries, before a corrupted inode could reach
writeback.

However, I agree that an additional validation there may be useful as
defense in depth. Would you prefer hfs_is_valid_cnid() to be checked in
hfs_write_inode() as well, and should that check precede the existing
BUG path while otherwise leaving its behavior unchanged?

I will prepare the next revision after your guidance on that point.

Thanks,
David
