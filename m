Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657796;
	b=caQIgHkWNtSmnfyxh2vjhMQJw8wecSYIdfStHdkHfBJunKxaV2XjlgGF4LC68GlaGu0B
	 IznkdCAUhR7mFzl6mfyip0Z8diwprFBz4eOK+mxqwGru3EfKQPPMDyXI3FnNowwFtaLwt
	 WCI0WR1xlj9qk6FQWKMOknBFZSRHC3plEkud9zA2ZL5i1TCCyFBUqu5i0K8xLsatoRLe3
	 kxz5vvmf6EyEPcy+JY7ZZsz5MepJ73EEU7IERMPwIRoNS3MYic+gYb+gqHjX0CrMeoqN4
	 nLjJQYwhVFcyZFY+X0lj6npJE6UvaeC9lT3JOxv9si67LAmqt+p6lZgt6twu9E/wl8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Cw/ZCD9ESmIvPuVt31//P6WCFhiNU7mYCdD+27sv2XY=;
	b=d0Boa6F/uxmXrrhFcl9xoi5GGBE8RJxM+qgRfWYrjaaao2tV1aTg2L9Iq0/h9LnCiZoc
	 9Wwst7EEvr/Z7D7Oa8UEXZilXlQhQfAm5ODtx1ZGYP+yhTIJstzTlva5yZn7kiTqDtbXh
	 K0/ncQtbHjInxGBEUPYmV0WY6t+Zciu1tsYynkVTSlPgodyolDDuiRYV/d7b94GCo5Jhg
	 uyjzmYuGamO5ULroKgZE02/nV5RKOB0tfrcg4JQg+6nJVHlSayc2vkxllAcrVmn4We6B1
	 hM7A61SFwq1NW1nu9ee4rlUMoWSNTofgSJ5cp+RHYv4WvOGos6hHLE7hb9DLozBevEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dv0WJtS1;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E7606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 01:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B7E7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dv0WJtS1
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a32576da88so3687910f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 17:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795657795; x=1796262595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cw/ZCD9ESmIvPuVt31//P6WCFhiNU7mYCdD+27sv2XY=;
        b=dv0WJtS1Oa9bALH4bZIZ0/4+htuV4Fr0HVoUrStZVtHMceAIIV/Qb9myaksaqW9s0f
         hr7kGd04KNkBN3Q/lVUO1pwX/xicdGKjOu5pB3ioQPFf7aXCOOH2pED0xkmEKcs62YFW
         +XQylm1QUYKTjN4oEICBYMcxlRal6V3FXHghSw4ECDk4TQtlPsas5T+bJiThoG77wfu5
         WF7QAaNUAzGVQGtyRpwxp2ytlkjycH+cFRxHOU1BX+r2xKlTQDhTda7XqOf2sr3Q9hiC
         mOjtz01RU4xnvcoMUR9dATR7R9GacXtIlmrKvzmSgDmI1kNYr1/CPRaXUiLnHDhcZQ6d
         /+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795657795; x=1796262595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cw/ZCD9ESmIvPuVt31//P6WCFhiNU7mYCdD+27sv2XY=;
        b=t5qoL24c8DrPxeMY+mtqiGmEVMTieZ+SUfJ1UTGBpkC1311HjcbJTg0zsAVSpyqqFS
         gocXwZ9qTkCDDI/6ztR8KiRFl3gaKncqr2YANw6GRrSWCLM2ITVHKqH4pfOn2WiNmamD
         wiQV/cOEhMw/89ZujiknuSUCLmYznoRWTZakPkPGwA+/KVvtg0igsnf5J/xx+A4MVKsh
         KRaWZoFQSeUmJOedMIIveS/rYaN0ZoU9sMNsWqCJj67VjuxNhaDuJIzRCbo7QqbHyhK7
         J4hkBozBhFvDI14cLuo7cgSM0CfY7QJzzHPQ0HLM6GhN7cSKniCeCPaS2g8lpaFCiAmf
         JlnQ==
X-Forwarded-Encrypted: i=1; AL+hErFHXMMcscj/okqo09LFq4BEhCsHE1eWQIgUEat3R3Fr44fa4InL1zUxJ23pZ9My0TPYV+DGNVYgs8qBV7Y+@vger.kernel.org
X-Gm-Message-State: APuU4Z9Yjwjbrmn48RN32KQdtitdtjV3vyvJ2Pnl5JrwSrxn39QsgF1m
	j+aDqIcWrmcJhaR0kFzKF3rqEp7j9Pa792CxanlCgN1HacELDJ3Val2fAMq2eeFq
X-Gm-Gg: AZFdTZenirsTTRxY/liKiEZFBaUndtXgMDwD+MQWwGc+fg0vGe2VlWO4Rj+lnA1wCUy
	Ogt1dACDkRdoSrKhW9+9XtfLCWoucUVqyKxyPu7OcAyY1YZfiPc8B462mmU6i9Bul4gU+uZClUh
	TtaC+9UwcMe6D3SBlCZoySSS1N6uWsswJpgBAADYcW36KVAwFQ3QyjSPggkebjLcF4s3fnLSbjj
	0HPFgeGe478YcMpI6i3gYBEQMUttwPfXFdtrEOiaokmm2pU/o4/MbKoy7LMY652LEiQp6qV7fCl
	7esZVFjh0RwEW6M/lSRkFmqJg0jSMb+QBG6orSUT4UMjRb7pUCDSJDcT2TiUckZ2Ai2Z6hfHGfv
	rkXT2YXd+c7spMRWPyQ1NQ5/g0tWZXHvNQl6yQUuNQGuiEEpdBnlbKc8u3Ie1AMhLDg8N8Mu25W
	GgSnA8YkDGwSerHrdjCZ371sYEE5raXX6GbewzeSMVUsVMJRvWzEDGSFyf/WmnsoQyk9GVWyHUK
	+tlOYvxd5z2JU2LbUI84YDVhyqFwnLou8XSUUpNzuJB11h3mzTDcONP9XbF7nFBZYmMIFNTM/QI
	LctXC+Ic0G0v2d9FhL5GXORzIJ60whG/5vSKqyQyxexqwRk=
X-Received: by 2002:a5d:5f91:0:b0:48d:f9dd:e3df with SMTP id ffacd0b85a97d-4abb386134bmr34709391f8f.18.1795657794701;
        Wed, 25 Nov 2026 17:49:54 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4b34e9c3ffesm21483408f8f.19.2026.11.25.17.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 17:49:54 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: josef@toxicpanda.com
Cc: James.Bottomley@HansenPartnership.com,
	andrew@amutable.com,
	brauner@kernel.org,
	jbingham@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sergeh@kernel.org,
	taherafahimi@linux.microsoft.com,
	Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH RFC v3 00/90] cells: a container as one kernel object
Date: Thu, 26 Nov 2026 04:49:19 +0300
Message-ID: <20261126014919.2135815-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
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

Josef Bacik <josef@toxicpanda.com>:
> - File capabilities are ignored in a cell, and a cell can drop from its
>   bounding set without CAP_SETPCAP.

This is useful thing on its own. Don't require CAP_SETPCAP if no_new_privs
is set, even outside of cells. Similarly, a lot of other useful things here
can be applied not only to cells.

> - The host runs no usermode helper for a task of a cell, so no modprobe
>   and no request-key, and a core dump doesn't go to a pipe or a socket.

Again, very useful thing. Consider to add it to all non-initial
user namespaces.

> - CLONE_NEW* being EPERM in a cell is written down as a position and not
>   as something that is missing. (Andrew)

Note: it seems Andy Lutomirski (CC'd) wants something opposite
( https://lore.kernel.org/all/CALCETrUD4vh_iSHV7G0bprUFU8=c+ECo701-tXcbQ3UXBWC1ig@mail.gmail.com/ ).

> 8. procfs, sysfs, devtmpfs and cgroupfs. There are no per-cell instances
>    yet, the builder assembles those with what exists today and can get
>    it wrong the same way a runtime can today. Where I want to go is each
>    of the four taking the cell as a mount parameter and showing only
>    what the cell holds. That's a lot of work and I wanted this out
>    first, but I would like to know if anybody hates the direction.

Again: consider taking userns as a mount parameter.

-- 
Askar Safin
