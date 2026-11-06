Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971880;
	b=xvhb7ho6vuWgSFoL0D9jCFhxQKZ+Lfx5JX/uAT8wNptP5wrlkVFFhZTa8DnCpzavA7V4
	 lu0uBQh3gpU26hEANoqS97KGn4stODok/kxv9+6MTZpe5bfXWCfLxfnTi1yeaQ+dTOpNd
	 AOsbnz+ksRyOWfJst72bz+C/07ukOiGrttlJiDQ7OG5o43geXWJUrLQrEGtNZVkRBFL2z
	 Z93/GK4KOB5YCzn3m+l02/EIEI1d/Taxfqw9vvVEgMgykuMq6YaGlDNOwc7ePQEWjmcq0
	 9/Wo4dFLHiuIfxLqK0T+DJkPoJvbqc7FSGDovq4frUXAyasii4zK35wu3jXdnzbNj4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G6DwXFsKVtS0DwVfDaHzAgdX+wZZI3a8OJ1eN4exF+E=;
	b=DAve+lHvMhNucTHAhylj8MQ1NApGmNCfsW7ypc/6kFNlfsSyEWnozywjn3HQBAFfgYJE
	 gZTkznHcaYk6U1tDHef0djBn02lAba3x/sIjMMs/l29ekRrWMnUqutq6p0l1/KMJ8se8I
	 KcdeLyGg3ALPyCz4260VZdCpAighL89JGCbs6pi2FaUwUzjkv+EMAGYdBQsbdIHqoamkN
	 jE255wR8j8oO7fbrLALtLq7ruptfB5/A0Q2HekNdN6dUYLK1lyjM9vajRnFFnh00GFuPK
	 e2DFnlR4IzkgZFNCU8yr1Qnor9lmcHPR78ek9Hw82b/co93bXfNCKlgGx4hPK9T2Mig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="S/NyLCh4";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76599606A32C
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 13:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76599606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S/NyLCh4
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3282db206d3so1315056eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 05:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793971879; x=1794576679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G6DwXFsKVtS0DwVfDaHzAgdX+wZZI3a8OJ1eN4exF+E=;
        b=S/NyLCh45koJw3aWO9oB5LHT8jb/eDRdMkihc5/fHLq87Rg8V/uWFV4LxQKaaIj6Qp
         PhXWXPSmnD3DlUYE/7htwlzCiWSlde8wBDIkKNetpQCFJKhsr9qKq7xk46cZCvm+RWNL
         jWf+b1ZdcWA+HEOouHO1wapzkqHMx+M+XfgxP82RsnmpK9euNX1SgF1vqM87wmYh9l7W
         ZTkuVwHz1V2b6nEcR/vs+ZfhJ+DiFnyKXXyka/0VE9T+XGGw5+vWaUAmyyQcZBZjcMQE
         2KQ5JoHR8Bho+Ww5Kzq0W1IKWL7rJ3kEd4VFvr8/DjMFOd5LMW1zBGeeu1tHFHANWmRL
         9FBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793971879; x=1794576679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G6DwXFsKVtS0DwVfDaHzAgdX+wZZI3a8OJ1eN4exF+E=;
        b=KC7U6/S0KgNaORCFgRGPTHArInZ18P/kAZ0HPM9/n5zbM6xHLme+z8unKm49v3khH8
         tk0hfyz9vRMCQ+ey4qljsm0uVSarnxF2mhLcesHLkDIJsswvDiSoe5e1LM+GV2W77Ssd
         tZn/ie2dzLUGJCNXmbZCUb8olZA4UzTa+UZ06ULx1gQlr9GExLGPFCH4JgsfKE5rhLfR
         NfGYg6vPWB20hGTPCaUgh1tW44UU1NE+IgtayyU2dAYsQEZ1USZFVgPZCRwbC2BLCMJr
         R7/9Ho2GdCU4jJVGYsiFw2OlCKR9WLPNb0LYNBt/i7CdkoYot8wahPioGDAhnimCEHOf
         9OrA==
X-Forwarded-Encrypted: i=1; AL+hErGDuclGnDxxIWZl6dflWHBGAZkaAyfmYTqz0T3JF38f5wZgmeorwZzu8AY5nAN9HygOKgtS05yDZp/rls/V@vger.kernel.org
X-Gm-Message-State: APuU4Z90z6emvlGWKR5AvVc8Hown3K5LlcxnTuHCK/MDHLkMPpPQmCV6
	Tj93dQLYL6k9U5lvJ2OKT6zF6MNpjd9VHKj1VBRE0gjX251hvV5E+ieM
X-Gm-Gg: AYBFou3UethWvg1/VBrPnqa1rau3NWZOIyiByrFd29PBVGxuP8DC4H/F6AqQmpweSbk
	Wp9L2mlRcaYcnqaLIaQc/g3zdvXDbXCy8LYUajgh3zYpC1w1DoZZVpWykmdh4crEp2sVYr4LNcC
	BHp4NNPY9vTkdUdbkfhZinhDdoL+iKr0EfU87jr6UPvE+BSLmth6EOYh7ha+BLiCtSDC5ymZ16n
	Af2heWTlU6n6klaA8efH7dUiotQ9Yg+3xiYsBFNwIc5MM3ccMeTbC1bU6EZQjF7G7FN2zWD0TnF
	3WrgrLOQE1tCSAyd55u9cROjA4Me5lRdJDLyglPoYDmMDdaVGJaWtoiI88cerJZ/nlcntFTHuXM
	S+3ADyvLv/upTigYVMzze9tMeHy+4cED3GWD8XDGBi7jkzHMGVVBTHOmw7KD93muKP7dkDuyA+k
	rrb+Znw1Ue4L0DzFDDDsMWTJ17/T1ayws+hznZ6qGXqY0aoaBAzuoN9BEI1wcKOfo/lbIIJgMyq
	DBatYnUokbNV0Nd4clfog6vU5RC1x68G7XBVjoaGivfRbk8h66n41dKc0KaumGhk7fTE0C3gkf4
	uwDdbbRflDoNt9n8GwWS47Mb+get1LRGgSGqCj0rgpmhMzgtEmwvCPLi8109YtpmPCx5kOTAgMO
	JKu2tcDkaal8=
X-Received: by 2002:a05:7301:4701:b0:369:f0de:259f with SMTP id 5a478bee46e88-36f76c170e7mr2928285eec.35.1793971879318;
        Fri, 06 Nov 2026 05:31:19 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651e6b1sm15269305eec.3.2026.11.06.05.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:31:18 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ntfs: do not convert a named $DATA stream when making room in a record
Date: Fri,  6 Nov 2026 19:01:10 +0530
Message-ID: <20261106133110.2659482-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106124553.2617026-4-wahidzk0091@gmail.com>
References: <20261106124553.2617026-4-wahidzk0091@gmail.com>
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

Hi Namjae,

The Sashiko review of 3/3 also suggests skipping every AT_DATA
attribute in this loop, not only the named ones. I'd keep the unnamed
case as it is, for three reasons:

- Converting the unnamed $DATA from this loop is what the loop already
  did before the patch. The patch only stops it from pairing the length
  of a named stream with the unnamed inode.

- The lock order the review points at (mrec_lock held while
  ntfs_attr_make_non_resident() locks folio 0) is the same one used by
  the direct conversion near the top of ntfs_resident_attr_resize(),
  before the loop. So it is not specific to the loop.

- When an EA or a stream grows in a full record, converting the unnamed
  $DATA is what frees the space. Skipping all of $DATA would turn those
  writes into failures.

If you'd rather drop the unnamed case from the loop too, I can send
that as a separate patch so the two changes can be judged on their own.

Thanks,
Wahid
