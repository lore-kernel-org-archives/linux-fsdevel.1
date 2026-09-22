Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518055C30F
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092530; cv=none; b=Gq73iDRNwG+LW5OrntM0Rc0CEj8LXkW8o2kz+B+BsQyGTfJjL+bJybBaMv3LuFOBZRQqUgyiLOAUaZw+NQfV0uS1Ejoqba94gOaBB5IQklwzesKd8nZup652uDkmg1BKUUOn0wRVTMm8xy0ooZ6WpO0iFMNaozA0jBtlLsWuy3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092530; c=relaxed/simple;
	bh=7msfHNMkfpLZ1KHMsjSAvVGA9heuhV84fUsTNvFtIlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrLggDX/5aQ87NAeTAvFzYX7iRRlDjYGYNqAHa47VQHqaCXJspS/30i4lgNQrGv/luYniwOBqeajc8kJPoXPy+deCKapPz7d+d6HUtRAnNTq4CmIOdbBUVfPTuX6/2XrhPUzwBBhJRsuSFUbjUuMdSqHhjFUp/yjOJJuHsVvKUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVWUsKOn; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVWUsKOn"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398a1676000so41535a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790092528; x=1790697328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wRArySa0Teo0omwOHf0fDNN56RT6AwwYq14UA/kvV5k=;
        b=NVWUsKOnvz4lNQN1z14H4dCF4UdpN47ygDjrHGzORKbmLRI/6G8bGNLzUycglP6O/0
         tjUdsLkoV4VqiMUztZArQqsN730TWz8JzAzYF1nS5DgtjXKBbQHlvb06zI3Qclb5ytsk
         QrYNx0ExqPQcvlGyy4gpGmheLEIED8i7NM0GLxlPbopWZh9uSrmZHcOWfUrBQ9hEFPMA
         0BPME56FaJWRYeNnBLeTh3wkONEdGuVxXJoyslZgBNBB+ENFckJ+95TCD+dx1JsvdXJo
         LpjWa7NpXy2PxYExl1/KNfriVkJVIxMXgpiMw4D9PIgm3U99yZwmO2ee73YxLeDvSHLv
         nMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092528; x=1790697328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wRArySa0Teo0omwOHf0fDNN56RT6AwwYq14UA/kvV5k=;
        b=IYzvpKZX0cfFgUnrb91fmmKH1beqIUkuQgBkTz6UylvkRDUwZbhZcGKNcQK9BxduaB
         wNDUSSCjwuqPlMUJNo4BURTX5FY0greJ/BZR4qrCs9pw6xcO0cO2ZP3o3zoz7vFLLRl+
         h6T60q/Hhsolts1P6E6Rd5+pCCwdkFjEcXNTl+5KXwiTSQ0Ewyn+p1viCxorCnCJINP+
         WzVZrZaQONFb3slNsI+UPM3j5ualBThW1kyhDVufOqR0B/2+0p+WGrf3rfoT6WHk6198
         1PG8kO5sUpapW47yHST/SvtofwYzYG2eN2Xj/3RP2QUeT6j9p/38mn9hx4u4SBELaKLH
         7KDA==
X-Forwarded-Encrypted: i=1; AKwUvBy1fQ7aUCeA1jn02slH1YCJUgUZ+ZVDDkOP9AjlsXdMd6CmrlDGldaXwH1q8A6Katqg75RKjvSisC2fAvEG@vger.kernel.org
X-Gm-Message-State: AFuF++kGoelByfhT6lzEpvN5TqXV7Qrg/xEcshMQl1t5Kezd7ydC5q/Y
	7oaWCoNVWeFRJWU79lT6WaSePjJrEDDegbNUfoJGKYBGYswY240yPA8hStr2d3Aq
X-Gm-Gg: AYBFou2CPJBmy0AGpXTukSxEQI1bzrpL7+9WDRIzOCBU78iLqcNFB865+DWZXQQG6Iz
	YtbMN+hxWPk2gqISY4fADg+X6Ln/InigvyTOZ1FukSJQ9dTAcDCRzTdWeunNXQoBEOUqK0hfJHu
	OZzsGiV2noOpFgdVX0qW/7woDrcFFNm54O/SEKxRy82kppqD7zMPXRh5VwErwU+5WgqwmC5h/BJ
	ehBjH9IvFbqrUf6J8p8JguKJRoo3qozY/HYTFIbJJi7zbOqVsxUHFic54DK9myhO8HnzavvOG2y
	L60DwxiQW+Ieon8RsbKyDc7VH/s4viOd0g4oDSB/13KgfLPNruXol8hJZMnArUz01bYYWpDVfSv
	luivm70QhqJPoFra7EM70R31ufdQJ2dCtoTCleictThzZjvXGaDIa1Fi3ogE9dHL47JC53RaMb1
	v7XcJK9+qQMuYxAgZwvZTlVTeCRkVSO9bLx3X6nc2ZFo13UdwOTawagrq4lAh+0phgemLCWkg6R
	JUzlwFEW0dzp4xDVQ6FCKHPBQOCojY9tEuyzFwW5+/S14wNA/7DoV2hCC+ftprcC9w/eHpApPNd
	MJMThCz/46Jm8wqDxFNp+WP44D3kEV7Ad1YD5qNtp0s9VjAvuNqustKgFDalf2A=
X-Received: by 2002:a17:90b:2588:b0:39e:6c69:f474 with SMTP id 98e67ed59e1d1-3a0732431f3mr2031848a91.51.1790092527799;
        Tue, 22 Sep 2026 08:55:27 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dbc5451sm83910a91.7.2026.09.22.08.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:55:27 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] isofs: tie the name conversion buffer to its bound
Date: Tue, 22 Sep 2026 23:55:22 +0800
Message-ID: <20260922155524.1993425-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two cleanups around the scratch buffer isofs_readdir() and
isofs_lookup() hand to the name converters.  No functional change; the
first patch's assertions hold on the current code.

Found while looking at something else: get_joliet_filename() has been
passing PAGE_SIZE as its output bound since b2eb2e288604 shrank the
buffer to 1024, which is safe only because de->name_len is a single
byte.  That seemed worth writing down in a form the compiler checks.

Matthias Goergens (2):
  isofs: size the name conversion buffer from a named constant
  isofs: bound the Joliet iocharset conversion by the output buffer

 fs/isofs/dir.c    |  9 ++++++++-
 fs/isofs/isofs.h  |  9 +++++++++
 fs/isofs/joliet.c | 25 ++++++++++++++++++++-----
 fs/isofs/namei.c  |  2 +-
 fs/isofs/rock.c   |  3 +++
 5 files changed, 41 insertions(+), 7 deletions(-)


base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
-- 
2.55.0

