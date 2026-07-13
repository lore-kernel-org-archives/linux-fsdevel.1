Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F63342532
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980576; cv=none; b=CF0EW21iVszfy+g75MQExWDagwAHN4yB4xJw7BNDhHZgzsAuz2mtmyHzXXMEw2hyJoE5rSKIV9XBDu/wknoI+58mCN/5+ADwgRHESXD88EThFOGrpHrtTqeBrXCymvKR/ro3L5MjSnL5bCsvViRLVy6gbpQkSYNmycHISc72nV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980576; c=relaxed/simple;
	bh=SGRRJwDD4OBlImv3MsEy/eNBNzSnuz36aV850QQKpZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pwp6P/wPq4nDN/yzhTCMmpR6znya+XW78gKz+rtUZhXTpoeiKMJqhesQaAPt5YtasuThRmBOmi42gj7ZZVpeeFyKai6UiHpSOnmuK139YnB7i/aIyOXAGD0/3MZi49Yx9MEYVMz+N8Li/guhesmn8BEt0Ye3bTRsR7tnH1LjvqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmaHUZRY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmaHUZRY"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c029505b389so53247266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 15:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783980574; x=1784585374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vlB2md8CTyZJ02d9wN4dJDH3+O4ynRSJBU9awyUCPRU=;
        b=lmaHUZRYSYtfKezD23xesfkvcg1sPo/5BfHbTzEgSFxBR0AcHo1YAurL6DhtdJ2R9J
         bMkcdxs1MpR6LkhVMjL9BQC3VchJXTOz4NaqDoGPUssqZhGaaRn9alsCcCQ/LYgv9Lfy
         AQPt9kurf3ze4Tnoa/QJT3M/IoPH/uh9tYXw1tibEA/nx4A/aMMErbL+V6hKdqoM2z6y
         JUs5M2B47GwsvVaZtZhxGtADcaRGVBf7DDetHyIY0hrTDYZA6XrJguWLJSuy+bh3Xuz9
         hLO6dBiLDj2XE6gJwGprXhcboHgFUi3HOuLzhLcG8cIzf3vSVNQ3VXyui7jfBlaIMWbG
         YFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980574; x=1784585374;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vlB2md8CTyZJ02d9wN4dJDH3+O4ynRSJBU9awyUCPRU=;
        b=AzUjPN+zGEc+VfVD2koY1lCTUIXoE1XHmYSJpUzN9vnXwelgU4p+vYIy6cB8obB7df
         vzVYfTJeQtti1R5k4Bjt7SFyVlxsea/As2JMJiy1Q9dfVgoffxlWSOVyyeq4WMfs9XrS
         xaNCNGQ09vZFrWc3ABqqcc+a5YjecL4/7Or/pJ0RGewLCHE1+CXgOu/3+jEbNYv3hf3B
         N09Pks6vrg/f0wzRIgT6wZ/sQ4P/HkRTlmPwAgerIWgOvPtXMTaTn8x7tinw2MgHFekR
         nr4Ny4/nRRnpvAtT8CfKSs5xQaApagV08giju7Hh8RaCe0FjYMnUIbdgWB07JSx9Nfad
         9Cmw==
X-Gm-Message-State: AOJu0YxP+lIEa523U+llT2bcqfB27rfAQCHuuIO09K/lK8dGgvr6hKVm
	JthPK58LXA/N639COKJzuS6Q2lrEhP22cK1CGe8QxZVOftYywRAHy1U9BPYrNMoLP8s=
X-Gm-Gg: AfdE7cmEF4vqQpztDf7uZo3mhB04k+30AzmzdBNornL5aXdxaw9VArZyKKPJuhFHCsw
	hA51r7XdYZ6HdmK5Pgs81Kg5akihjsGoY+X6HDlkef3nd69DW1V7N/9ZBFufeoH/BcfzSzZNRqZ
	8rndHyeFBQ7kCZILO45S40CFJoxQzK+G20sBf8zrjZEKAzFw4NSKtiTx0Yz5Gr1CNqPEX5ZelFl
	TmkF/eaH7/WNibqrEpFNjwnjsCOiGSG/27ufQsNmfsHQ12SYEgBcnEzRN9IuFGoja9D15NtiIE3
	wyd64GH3vTZPW9kK3Qg7Yb+0YqqApOcaFMsKq1uNd0LBzjFvrR0aSfOqTfRhToVtESSsdWAwwdq
	36AkmIW5cPSvy8VIeH9als9NNjVVu23E1O173GPg+M2gFvQNNXB0NR0SxeGRv9weCfGY7P4GjA8
	1vOyJaEH4dCsoSuWewPJRLKYz2jZielyS0B6sRkw==
X-Received: by 2002:a17:907:1c19:b0:c12:cb91:58aa with SMTP id a640c23a62f3a-c161ea1c466mr496690466b.24.1783980573348;
        Mon, 13 Jul 2026 15:09:33 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15cd42b336sm883801566b.38.2026.07.13.15.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:09:32 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: [PATCH 0/2] Fix for unintended FUSE ACL cache
Date: Tue, 14 Jul 2026 00:09:30 +0200
Message-ID: <20260713220932.413004-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Christian,

I bet you did not miss fuse acls...
Ghosts from the past have come back to haunt me now.

Let me know what you think of this fix and whether you prefer a fuse
gate to forget_all_cached_acls() instead of the suggested vfs fix.

Thanks,
Amir.

Amir Goldstein (2):
  fs: preserve ACL_DONT_CACHE state in forget_cached_acl()
  selftests/fuse: add ACL_DONT_CACHE regression test

 fs/posix_acl.c                                |   7 +
 .../selftests/filesystems/fuse/Makefile       |  10 +
 .../filesystems/fuse/fuse_acl_cache_test.c    | 348 ++++++++++++++++++
 3 files changed, 365 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_acl_cache_test.c

-- 
2.54.0

