Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543907;
	b=4ykwJwbbvzGQKatHD85zdMuyZ0Qp4m1vCYh6z3TytpYaJeKwwFayTtGpejt0inRMcDLy
	 BDPKB2gSAeYDQvUwuo5RktB99N0mbztqePMNIYbmqxMWGLjiABZc5Sh0lhDvxFNC5nXGx
	 yVg24iiHusy5zjbsabK3cxq7Lbt0lWBXp80hla4h0ni4F0ZLFqst+utNk6Rl6MTJUM8Jt
	 Z1pNPUNZRfg7L8kaeO1/+LbuVkRxZ7d897OHeXgBpTLWdyrPRYzzCWjNGYix/qD6rGz89
	 QnN12VCnKOCh9Vu2i9SqJhQ5eGhBVHrkFIb1d3oWAKbmvADxRtPTZZgOmKIxQqLOjTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543907;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=aiZpNl+uwE4TnFcTqpYk+3BvyMy/85ssubMrmipa0eo=;
	b=YBcSUyEzHHcFozrftpC/jFhaVaDUmb0po4iXV+H0tdHga6MNFjuuwR0CIH3NK3MWmcXm
	 T6sx2/eeCucs5EEGrPJvuQUyr19jh9Yl0iQGJmDyk93VrBrEiNNua8eSz7qkj1NjA2HNU
	 oq3RlCihOQ45JrheN7bcTzxVMhnuUO24oTKRpDjYvLmRW6ph/Yuxtvj+siZu4BIRyY18r
	 0CicXz1XumR1W08gsyUeNS8+d7KatSxl3ptOGE1XDsKzye0FkK0cEfJ8hMvUvIdSzJ80M
	 gcz0c7CwTgAe4hyRdqh3YwRuterK1vugNiy1bnfRWfrcU8AwWZskhYGq4GyTpsHkbew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OcZHRr4j;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED57606A323
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 18:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ED57606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OcZHRr4j
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4b0a307487aso25325675e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 10:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795543905; x=1796148705; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aiZpNl+uwE4TnFcTqpYk+3BvyMy/85ssubMrmipa0eo=;
        b=OcZHRr4jdmY8U1ocHDa9fLLOko5ZZG0AkgUFFlk1yatOxrpwA1tgw+c7XH0C20+FL1
         JbUymkY0L5CI11NlQYNdhPmNNCJN83L3bvNAUiskDP8ejYQoTqHGNyNXRVVs9liiSDsp
         Pu419xLFrjN0EyIJUxwCOkn+G760jmx66EdIlMM6p6F4NuPyn30bKdCC3awy1+21BtBt
         GaVbYYYbXcvuhbFgdvi8oI3tU88qx/C+ZdI7QlMiDmEU+EfkTRz2OvDgdtpbTSmsotoD
         XTSHO0emKCfBfhqqqVXoxaWiH15/OvtT/PBc61U4vmAoNX4iJYJWU537vYx4HJRThemN
         XuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543905; x=1796148705;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aiZpNl+uwE4TnFcTqpYk+3BvyMy/85ssubMrmipa0eo=;
        b=j62byRjbnjHzWcDsRzrKHXYeTuP62OJCkSXUR7qC214xGlZ6iZurLV6lI3VbOHG3BF
         mt1pJcxh5BJGLWSHipTTBuPR0QWONnMut3LajUws6R3DAli4hKrAPeSkh1Avzo4XRBqZ
         PGlnsbgOL0LxXsIhvmUDla077Nen5Y4Dmlvcgo4EMCn6gIh4j2AKjgcl5QuiKF41anne
         R++k9oSEisxu2LZErMD1UwC6Q5mDUBwjN2KYPdDGj/POL8CysCX7rXsBXu8pmoPO4mKO
         s42nsgCNcU15tX9lgPohLJKGhTuDLNW31CVFjMlb3Ght5owzXiZDvQlbBQhbN15WJfVk
         Db3g==
X-Forwarded-Encrypted: i=1; AL+hErF3Rlhw8EDjZ8y3CaJfsB+yy7ttkqv4gnZf9fwLmgzkQtE5EjX4bZcrg3KsXmANKUITZhbX03OlLfWUhZRo@vger.kernel.org
X-Gm-Message-State: APuU4Z+i2Kghu3do7VRFpJ/b8t9ewBebcjdFezKBjPDN83/Qz2p4oRX/
	RlDJTZduGow5kbQCsAuGYKVHLB4g3aL4l6zZGVwLelkORVlNAABVukBOW0pqlZOKs3RdEQisqA=
	=
X-Received: from wmlv25.prod.google.com ([2002:a05:600c:2159:b0:4a2:6ed:d59b])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600d:600b:b0:4a2:167a:c939
 with SMTP id 5b1f17b1804b1-4bb88815f1fmr319343915e9.21.1795543904970; Tue, 24
 Nov 2026 10:11:44 -0800 (PST)
Date: Tue, 24 Nov 2026 18:11:44 +0000
In-Reply-To: <c029dfb0-0745-4b63-9577-1a373f7ff184@slotpi15m67>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <c029dfb0-0745-4b63-9577-1a373f7ff184@slotpi15m67>
X-Mailer: git-send-email 2.56.1.663.g77904e546d
Message-ID: <20261124181144.143605-1-dmnk@google.com>
Subject: Re: [PATCH 2/2] nfsd: enforce cross-export and may_linkat() checks in nfsd_link()
From: Dominik Maier <dmnk@google.com>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	dmnk+artist@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Chuck,

Sounds good, I'll wait for v7.5-rc so Daejun's fix lands first and
resend rebased for Christian's tree then. Thanks for checking (and
thanks Jan for reviewing patch 1/2)!

Best
Dominik
