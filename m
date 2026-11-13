Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565562;
	b=vz4vm8usJyDAhnjRsjcH7boTGSRBdRf76ZvisQ4IthE+VmyxtioTiTRZ3EBue/qW5Bx6
	 gWGbF5WHDoZM2SvI8ugPsY1Cc2M/iQQCkaMo6HyPx8HLb7VAlyAA3aA3VTFaI/tR8lgIr
	 UcZDyv0hQrMopUMGEdZjnHW3bJ76cUHXOKyk7yDXwZrIJnp2LAua/ASFytflsKZ4VcJLn
	 peU7EJRip2s1n3X+YYDuac9QJfmv0YtCT3nMADYLFJNDSCTmteh/O1MQ0tLAIF80UTiFJ
	 rB5P8IB3luEvAayBvZXHNza2DX0ofmb5LBbLnEbz+tiefNYLj3n0cKX/qWT/U1LL9rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
	b=QhlmRAQjDul78LFH0mzb5sKviF5dssoNQkASwdFOeXlc8ZtWrZVUFoT2uzBibzjhp5zN
	 dvXH84jBDCE3XlgFRKC72cB1p5UfyCK5tdSy9O71tL63WNVkv0fCjvwM3hf4i2LeLuxQL
	 XY+6+vvJVs32kfVxQbeKjyOyaFCGRus7ZT4P/l1Z5WX91CfkbrvfxACwWJhvZlMqnu3Go
	 qi+8183dkg9DIs6FH2zByiPWYkNbSUf/G3lFXTkY48l/MKPS03s2YBbvKM5w6lQj80jkZ
	 eV0zaRBMeKNgwlBNtzDXv8lsW3wUEX5A/InWjtDpICeGs219H1cCqgICHwcWT515gAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EhCy1rjV;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD1F606A88F
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDD1F606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EhCy1rjV
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b80834ce1aso1170715e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565560; x=1795170360; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=EhCy1rjVxVdFrlqlBXdnWdhZOgju6UqPO7MHP0T5eDQlLH3bu4fGnJjBmSeu+X4e2W
         fqknndYp9WUsPcSw+hMOJQKeOCVQ26f4CApHOuaHiz0ZnrEcpw06GAGjRX2e/v0KskXR
         kPbczhlJA2JL/E3RYwJYZ55bjMsTqV1bcwrFG/iNBMGzSlTlhWz25UxyOw6nI4axYZSB
         u0krz81cE8qJBpZN+Gj0XIkGJFuZa0vCttP7+3dXPKfvLd7fzcQdMwTNK/JaleYs6P1m
         dJAReh6EvrYwFB4nFlJdvgjX0mrHV5c8k7KozarvFnbaOIXtcKdLHY5nOcL1YTJjLQtf
         x2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565560; x=1795170360;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=GIn9KRFrcanBHyMuXMad7W6J4JVL3AgNBbP7O8sGJACXGRhfB9ow2h2l0y/F9fKHpM
         4DogJwawVNG4re6msWPSfvkiI17NEnzv1NHWSVR3K2bF3NryUeH3iUMjC5hdeYwSDsve
         Qqac3CSdDny6Hpuhx1ZOWFOlNHvDHZ67xG/HQtHxfiGCVGHNldLuVEvMlN1xArTiTBym
         E0J9QlXu94rxg37rBvJQ2nrpEOoRvXerKDeBvVPVlmNbYDQZzrIuzDDwNzrQSixtdwZB
         TivbVhaQUMuLt+BHGzwoPmADFHu8pXC+0XDk9d2WsMe83q2OgqppBNAM6+xAjENGmAaJ
         YswA==
X-Gm-Message-State: APuU4Z88JONZZ+Ot5TVbdYe4dCeUqyUN1g4Pr1l+ANLj9DPBfE6LpJVs
	RXHG3dlGIpAt87PG+iGHi3+qSBU4MeFV2mVKeA6R/uMlG3a7NOGY/ldyugOTJmD9EqRj
X-Gm-Gg: AYBFou1mL8yqZG/djMN+uM0Kis2tccsGJ2Yx6gRapFm7v5PJxY3IAx8qZE0oYh7G9ez
	jjjWDKgs9rtzJ1z13D78GT65ABfzPuft/JhvoFt8xAxx22UpdOS9BmNLpintPfmn+lOHS3Z8K8F
	F1ydbssSTsDEwConpfCRahvP34/JQaZCTjLdb+DrZ3PghbX2+kKYTP/ou41rXL25Jwpw+yoFZ5E
	KZz4BQEShh7x6hsW1/okmaxtDyLHCU9VeynlLkj582r7buOZPFS7qs01ZqCNAsc3i0Qc04ZRHTU
	rwScDWg5GqFCdJDj1z30qnXmRbF5njv3AXcFa4Ya9ZUDupyoq31X/tsp5y3uu7NlXu7rle0dvCT
	nCjjMH7GTe72G25BEBLPsrXlI7f0jBemKZMMh8SZV4eX87bpq9azUExs443ux2uS3uri/6FLEws
	ro8+tXhARP45MuwJDdB+NIlZF0pRknbBsXD6nFYhG2AdJ29XpDU31Dzh2PGWoymrPxvUECjbIIH
	ILebuHAh6o9ccUFS5jcyCJd3JV9/Wc67eexIk97jG0chw31o2m6VH6e4BJmoLRTT8xroprZ3iOl
	nJmjmujnJtKKLykg23ipODtyk6XT/GAPgvRETW5piowl4wbjnIUrO78eCVXuobs=
X-Received: by 2002:a05:600c:4e49:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4bb55aa999dmr38995625e9.33.1794565560090;
        Fri, 13 Nov 2026 02:26:00 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm244439965e9.1.2026.11.13.02.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:25:59 -0800 (PST)
Message-ID: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, Chris Mason
	 <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:25:57 +0100
In-Reply-To: <20261111151202.GA11391@lst.de>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
	 <20261111151202.GA11391@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Christoph,

On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> I've seen setups where people use fuse to mediate access to sysfs
> sysfs in odd ways.=C2=A0 No idea if that's still around, but if so, this
> patch will break it.


Oh, that's painful. Do they use backing files for that?
It's a relatively new feature in FUSE...

Kind regards,
Alex
