Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03940DFA3
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949647; cv=none; b=VWhVEU3FuA7vMYTccfdPMvWMB4K/P8pbH/8cKZg18TKstrz5P/V1VZFWErpYCET9htV0klUTXROzCf4PVBBDpOBdxIvHm6nQfuxKqvEcCpX9k3I72zonqlrcL8Q1jHZgDHEYk7UvhaIhOplzzGpr3EjnPNd96+/C3VkvpKVCXag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949647; c=relaxed/simple;
	bh=nyiZdk69JHyRMSxsgfCfmEEAuMmh5HcweuE0na5MKlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPdbWvTOVJZY9cFMB6bQeaamnYgzvQ2q0K7l4iekk65xFg+CS3icjaT7JfujXlt8ymJuVXNa9qrWQWlKWccRllmiU1S0XERY9+ORTQr9eF9WpHCwrbExdrXOo1WrRTBoB/QrEWq+EZwUK8Wznh5reLDK7tAnD+QOit41JnXl0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOHupTOW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOHupTOW"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82a646c96bdso832068b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773949645; x=1774554445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KKET5NPA5ASmk1jkTd7kXsD4vcOiadP7Y/oX3DOtA4E=;
        b=lOHupTOW2CZmjz9ZssNobBmJa9n5wVBwHhoX1Vbfe3vIoILrFRpBbwmtKtnOVMREJv
         gF8TPL/UpW8Q2ZjAWxJWojuzhHJjCtbeBEoZzXzAi+Y+D68ejyodU3GDGEOawbexUxQ2
         ++4WM+CW29D583OAuo9tWPIQnPYNdAH/Q71z6o2P9WQySuDOOSDk00uzxeWkNGiujuQz
         xZ7ai2FTPYgsEpwKGVEZcvW4A8HkuOX6bjXOwuFgp7PIrfP/mRyn/EpgoxmMjktOE3fV
         P9sD0WEse8pw0O1dOxpBXFeHTo0iiqfFmtr0yGQ8SJwkZ7UYYAwtRciG44G01ZKUe3Zk
         edMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773949645; x=1774554445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKET5NPA5ASmk1jkTd7kXsD4vcOiadP7Y/oX3DOtA4E=;
        b=V34iMiYht+EZ3ZWYoDYV6kpVoQg7qrLTayPm+rLLyJHl+6WMJ8RXngnls3c8KgtxxA
         5G8f1mBEaQgdrCLkqnGEkI0EkPDXoVzsIETrr/sRpgTcTbM3QYmZgM6WHS+lCc2/3K3f
         vauqiHcq26Sn3X6aUSe7sc+/I6LyAcv50ds/5f6nVMIYVN5ScosDuDRBhPy/8qbj4UcW
         CoeW/Qe0ynj48xmgsW2d7jGDkZYO2tlcWqGuL7A0i1px1SR00ei2QQiSBAQxKsJaLNbh
         2CgvhX6w6OT7iPIlLDAzYK/H1o1KAw/rKCAQeeP77aCFr3aXpU7vfdLN+kG7FgMh9i1T
         xNgQ==
X-Gm-Message-State: AOJu0Yw4HcxtuKVjTLMS39pyVooXFx3j09re5Upmq+8JB83jLOCPtLxn
	sfANQ5bmbEIBF/NVoy/1BTSo3IiiNFejDyYSh8WKwwYMF0TFwM48BZU+
X-Gm-Gg: ATEYQzxYlwbYbuiEgH5lToKMyw/IbcC7r1HJs6HnYLWp+gDAypFkmHbP4+1lWoVUwgH
	/rYE6f53pzk2gpYCnpCAO3WKWwI4osRoAonCpAPliN+Lkq0b7wWqyvDdeTe6tl9Dq5guxwOknNK
	3PhnE0LIrRLcKSax9B843KubrpAn/1J18Qo2myAWCSg+n6m9hWKlUYrQzwC7fRRrtnzWC5fHQkR
	sQIh67ILp5t6WC+3heRx9DRP6JLCeB7tjlT4kqESLMNDQj56JEs0qYRjcM5WhPb7M4QoajGMIep
	1JXXAzgRbXNTNATBQfu+ZYyIqKe+DsoZXg0M9soRxoLYp44665P2cgOGVzswHBwLOiHQRRdBJC5
	RRtp96wsJ+/fUFIyAR4PPxMCupUHGo4MHsv2es4KQeoyYXan5Cu2XtmmDFtU8oXH3KgOGfIU5HL
	gjIIC9a797seWvAElKqw==
X-Received: by 2002:a05:6a00:2d96:b0:82a:768c:9a49 with SMTP id d2e1a72fcca58-82a8c32727cmr360003b3a.42.1773949644550;
        Thu, 19 Mar 2026 12:47:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da7besm11132b3a.49.2026.03.19.12.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 12:47:24 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	david@kernel.org,
	therealgraysky@proton.me,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/1] writeback: don't block sync(2) for filesystems with no data integrity guarantees
Date: Thu, 19 Mar 2026 12:45:39 -0700
Message-ID: <20260319194540.3463371-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog
---------
v1: https://lore.kernel.org/linux-fsdevel/20260318225604.71545-1-joannelkoong@gmail.com/
v1 -> v2:
* Still kick off flusher threads for writeback for SB_I_NO_DATA_INTEGRITY,
  instead of skipping that entirely (Jan)
* Improve commit message (me)

Joanne Koong (1):
  writeback: don't block sync(2) for filesystems with no data integrity
    guarantees

 fs/fs-writeback.c              |  7 +------
 fs/fuse/file.c                 |  4 +---
 fs/fuse/inode.c                |  1 +
 fs/sync.c                      |  7 ++++++-
 include/linux/fs/super_types.h |  1 +
 include/linux/pagemap.h        | 11 -----------
 6 files changed, 10 insertions(+), 21 deletions(-)

-- 
2.52.0

