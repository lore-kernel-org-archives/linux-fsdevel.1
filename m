Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714031;
	b=R3o+dpsR7U7HCozBC7HIDPEHSlji6yZHKwilAV4JQr1afj9B9c1FIgAjeSX5X7+MmmX+
	 B+N1hpY0+eh9a58ZsOtZSEmFWZw5H3Ho1MNrH9eZREvSczbZZAEoUlxNw4fEPHKGFHdCW
	 2/KJ2k05hjlIHnkJUN1TRtnC9yV/h0hFspm2q7CtFFsWtBf8LInmeGdbwREt8Gkk/4nBp
	 eQTgGaFR2DaUqUi7tA4wghlrbpscrio4Nebwg2XDP09LKE4DDUJ+/oaiFlcQSk3NV+QHG
	 8HbWuJQSLQRzhDIWVzxuREILqukGfkLTQoxI0EtkB4MptF3qSlRKZBOHijX1sFmPAJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:In-Reply-To:Date:Message-ID:References;
	bh=Z4tHu2iJi/e6dWyG5BERUmTg792NLmlKYp88xKISYEc=;
	b=bci7cSnlrANXI+vnRUCbWneQxaLHWakfqR64ijCDuTbqg8eUX5Y/Y4PQBTPfmsVEauA0
	 TMCEaBwIF4qSOxMSc4Uo9+MaBaVdNbv2EuxLXZjP8fPt72xALHu48TSCXZ/UsIvHIRbxH
	 KFiK163TslM0A/Mkd5yrzk6zNvlVj9rnK37ce2v0EIhVef8k0/+TkgiMvvEowv/QvllS3
	 7p7CA1fOJ3NaDWR+nnCT1ASeF0tqevPcL3E/UFaaG34Gix2Ljbw7Hb3ee9/LISzPDqZW5
	 vGN3h8NEo+B7GuPVQnDvUxR33IDZJQjNsBi3gjmlFV0+pZ/P0HFIo4n9B8pOPDKPQbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m+GGjTur;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8E606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 00:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89F8E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m+GGjTur
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3282db206d3so888589eec.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792714031; x=1793318831; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z4tHu2iJi/e6dWyG5BERUmTg792NLmlKYp88xKISYEc=;
        b=m+GGjTurIp4URWCyne0AEstlg/S/hifwoIK3vMGc3ULvXuI2/avQDamAyvbwufeGmM
         d4UTiM6MJMonBPDDNPmFRfHQX//HDuDMtMBQOazdDOj1QtK63quy3MiaQuTpH82vLprv
         vx42K36TjgoJl0Nm6EriCVLzGGvhHcMqXtjwW8oaIhWml1qbU2iKsA0CZx9Kv6qM0RT0
         AYFmvn18BC+UfLUm1pzPYGE1a3fqz2ItID5ZRGn0AWKjkP1pcGUfgbfNkzl5tf5xh0pD
         B0X6oCzteP7JrqmNHvJ0dpyaA1YvhgOmNqRL0LfSiKZ43JNbXrFuQsFque5GTTO0G3yC
         t2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714031; x=1793318831;
        h=references:message-id:date:in-reply-to:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z4tHu2iJi/e6dWyG5BERUmTg792NLmlKYp88xKISYEc=;
        b=UxeBtHtpkzh+fznrkQkYqGWM0W6fji5QQlmynYB2xs7xMgywlqk65wu0zVdCZimzZl
         sPk89/0h7jq4+vB9HwWC37G3XZ4Owmvp3U3XE/0ZQ6twJPHMpI7JDJ4Dv2UO061+9DEd
         095EiuCPtJY2nRaFyoBtLMB7zp/obsqWQAwwMb00+Av2oz4Jlm9kuAgSv3SYg366kJ/a
         1YtAXnU+IN8F/68SVUBDjoJfeHgGrqFNYncyHNfVTVL3ynh5jSTbfGuh+RCBYoa4O3Vl
         BbwLXH4GH57n7cf6EtM//NDXMKALE2Znq7yMgYdtRJvEqTtyMAEy1dbfuYAzUYatD59g
         3udA==
X-Forwarded-Encrypted: i=1; AKwUvBwJbstTLUCBJPWm/ctWg7vcNfVZCLjT6kflF3We1w+k5/44qUZWqBjrT92mP64KjDm+Icu5AoVRGBgN1SK8@vger.kernel.org
X-Gm-Message-State: AFq9FYLXNmDQtqprIeF+sGHsIUXHaZdYXsQOO12EEAoz3PyhDzhYqApz
	QI+TyIipsJUwjGATiqeRDPsaU80JSkxsuCm7LjhVOglSN83ohdlE+JjS
X-Gm-Gg: AYBFou33MM9ctZiy2YZ+cMfViacIAMK1ipIGP7LxvdVE+mMn3rHEmpuMas2oPDUPTEL
	36qeBBy5HilCX+vg6xkZVUHgb2DeriOSqNS2kjXQba5wD9QYyh838GOwCi1GWON1H8ya6tX3zY0
	DCdKzvMpCMpSKg0nV7aUhdBIfrWe7vF37MjRsWLdK7dSq80oioVJEzRd/yUa/7QZ5EkqwtPavCK
	6JwfYZsbiHV9f/tzGGr8kSey+4XGETKCdPaRIri3lcdOfFcY3QySgN97l8l+FOz/HVmdgBhI2VZ
	KKq8Y4601gw8CB9j8UYSxWt3hZRPvwBeja2KhpoJsKrMDaRX9Cnqrj4GsAF+opyrN25cXz0lXmc
	7iBAZjpLFiYWla+4ualq4Xqp7GzEwTqYhYP5beu5/PWSQA0WpS7sSo+X2TBubdgvD+J9htT4ySG
	x38cLsDuS44+I/BPoCSIe2vqLX0EUHNPi8rjpRZoXgTp8e/DoUKdb5PUZ8HbnlWC99jzqs1oJ2j
	PLYMBxt9pEgMKUgbkPYpUEPZUiA/OLl7M6ZUndPAJ7zpmYmT7kDJw==
X-Received: by 2002:a05:7301:fc82:b0:35d:84c2:eb27 with SMTP id 5a478bee46e88-369d986918fmr703493eec.35.1792714030379;
        Thu, 22 Oct 2026 17:07:10 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9db7970sm1525194eec.19.2026.10.22.17.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:07:09 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>, xfs <linux-xfs@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fuse-devel <fuse-devel@lists.linux.dev>, fstests <fstests@vger.kernel.org>
Subject: Re: Farewell!
In-Reply-To: <20261016160037.GA107919@frogsfrogsfrogs>
Date: Fri, 23 Oct 2026 05:09:47 +0530
Message-ID: <fqxx5mpo.ritesh.list@gmail.com>
References: <20261016160037.GA107919@frogsfrogsfrogs>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

"Darrick J. Wong" <djwong@kernel.org> writes:

> Hi everyone,
>
> After 14 years at Oracle and 23 years working on Linux, I've decided to
> take an extended break.  Today, October 16th, 2026, is my last day.

I was a bit sad to see this email :( But then I read it's an extended
break, so I am hopeful that we will see you around after your break.

>
> I don't have any immediate plans to drop the djwong@kernel.org
> forwarding, though ultimately that's up to the sysadmins to decide.
>
> I have very much enjoyed working with you all, and I'm proud of what
> we've accomplished together.  Good luck!
>

Thanks a lot for all your help throughout these years on mailing lists
and over other discussion forums. Really admire your maintainership
style.

I also feel lucky to have met you in person at LSFMM-2024 and to have
had long chats with you on all sorts of topics there :)

> --Darrick

Hope you have a good break! 

-ritesh
