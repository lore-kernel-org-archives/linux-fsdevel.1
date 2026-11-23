Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472755;
	b=ZwoEGTGSz9HJeAi/9DFvVMxDFaipXO2QJ8GwdAenaAAq+6ZsYXD0Qxic7shG2paZJ4nR
	 kXl4SMFuCkJMdkFcTnEE60eK17SAX73e4DFLmgBVlbtKk+sD+OlhIe0ixdjPAIk8bhNNO
	 Nfn57MhrHEoxLvo9D47pm4d0mkgya8lAO+G43IDQGMsrk5fis+xqBp5zoPjuaVoavRdID
	 eNIJaF/LIUu3JXiJl0ufHvfS3KYuZVfxO/gzWOpVm7kdXimZQb2qU+tjwSinpFkv3x4VI
	 q04sKvaoXwUF9WkycR+l0XdptwCKqevo8VIwp9gtpRtABNRWB9011efVUXRaNWBEhaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=BtXPIF6zuxugnpKlB3s97+d2G4wbStRwqKqhiNp2vrQ=;
	b=JobQJmn3Xk6fnN0PuFjiY7Xxt7YHBmiCNODRqlEABFSZN9v+vo3ZKgSu8EL8yh2UjV++
	 Fm3oj3V9WQbtoW6vAyaLoE5pfHmhPO4D7Aiz/d3I+DTolqkEAjq/QT2PiEMcKGrkPBF36
	 nT1dni95lNqEWOyEBCh9Vo40QXXHWg5QaIA+2EC0vdASfQJd+DAKse2hOzpwffNecZXg5
	 KWAj+lc5HFlR1tSIQJKP7hLDAJ3alCW5FwcqCfOlH0hWAkn8RXqGSPJ+641KAsbrywkkq
	 HHHT/b/GPn19sqrgAArA9vr2+Qm0qMt9xQWzLnavgtr3iDs/lZ5j8IaAEvtnjEJTdpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e98dMe6g;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557FB606A322
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 22:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 557FB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e98dMe6g
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b0dba37a7fso31054597b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 14:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795472754; x=1796077554; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BtXPIF6zuxugnpKlB3s97+d2G4wbStRwqKqhiNp2vrQ=;
        b=e98dMe6gm2exhvdBQLkJgkWZLGoa89wM77dlMbQUqONXFgVk7P2OD4YwpM6qTPfqe2
         zWCMRjEShMVSyo+E7j8bLlZped9v/lmATgSh4sWfVtBiOxXLkUeVZJK2nwaNy93JlLwF
         4ifnmQfxdlbIui2CDquCFO4ZrctkHCq8oL3dYFNfe5HM7qs7Wx9ywANBnY7cj33+1JF9
         WFKMDQy2Z8xzz6C1u4sijqGj/tgMNMHMDHLPvFLJnpJNemYbwp7qOIsWuzsgcsNAeK3V
         KrZINq+g4/HcPCctpz9u7sg/yYZ6mUJDp7mjzyVuL/amBmRb9/ugWY19J1ZxToVih5TM
         Xycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472754; x=1796077554;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BtXPIF6zuxugnpKlB3s97+d2G4wbStRwqKqhiNp2vrQ=;
        b=JAoOJXjcVJftmtQ5REMJjN/Z21XBYiCRcBvq9ShFqe7G5wgwoeW9EIg7qW3ras6yr8
         lUk8RUe90c7DoS1R6CS7vw0P7FWw/VHSQkT1U8tfXai2AhyN2grKJxm5J+IG1Mf/ZVnY
         NYki20SRdZTmR1dNQi05HDYtAXG9vG5lVDGulYgc2HAP9zDOFQlpblltLKcahahKghCE
         qxG3X05kKd6d5z22t0gNTvZ6JTA6IB3ZwObgAuijMyHuNH++bH+RFOAGJg28zeCMQ34K
         CBV3AVqmYEElKoAaU2Wl2+YkC9TgoeYGxHnHG1eXw8eMEjF/hLBOisOehQZ/+Vmm8Eug
         D4Lg==
X-Forwarded-Encrypted: i=1; AL+hErFW9vbbq1vqPCIiH5YaMu9WcCGnT6KHMT1ww2KNDN14hnd04AuPfnGy6Hr1IxsKDyhbSWEuB1ueNO81V1i0@vger.kernel.org
X-Gm-Message-State: APuU4Z/XyFmtwqdbog6yHCarfAtAOm1iNsNWYyM4r/iiD467WMU0U2ST
	xlifgCE9uv57sAQDY9ad7PtdDgWyPTLdt6TxAapd+ejzSBofzHKua0yAZBJXuUUUzvI=
X-Gm-Gg: AZFdTZc6NwgGWl3sbOarUu5lp/78tt6zt7wY97l/2V9TWuKY0kPgjlicDaPazGVdFdh
	Y6ojN6zkJ+7/UtfO79j07PKzep+/tFEBf4m/l7vVOCcwARpdSxXA+5fAxT26jfiPO026vmpjh0i
	inbezzxASI2x+KJ50qZyIoq81quvXUZ5byumEvuTJWWjbc3xm73GhfhOIYrlp2PG9bsXLL5Ea5i
	Y4knmidFvVkPGOskuABcrdJDwQTSjFadBSAibdkwFej1iOR8vux5J1f8qau/5SkvHJksOM8i0Yg
	RyVK9fiwujSEMgX0ePpkose4HNytbCZnBSZdTPo0dsdVhc3eWJcEle7JNzAe+XYBsGezaZdJnwa
	Y26J2VlJ/ec9gNuTiWZSXAt07h7wmlOqLREjimJg5V3uFNU0SQ0pveqCzQt3r95AHdbBxXlnCDp
	+vTNQ9Rr9OViz1Ifi3lHTC8BW7/FiZy3bw/48SV8UY3YsBJs6vnlVOrcgDMqQfg4fcbIiGkr+go
	kDBHMffNycO4Faaa4vwveqlZS8qL+In4zCxagnDOxjvJ+IDfmc+6JgSTHE2NVWVo4Wb5LXI0Mx+
	RAqgdXgnnARiGChMUPNi1fnnt0MGoWBSm4VycTrgghGjPrrVJdtmGHavdeGZbtEvrlRrr+41ktM
	uUO+Iw5yx7mwtugg9c2GtRkbRGfGdGF67+KhOkmSTXfF2M2Gl+DFk/s6aaFnvspYO51Z3hqyxob
	ttig8MQzu/6/+Fr0fYhPM=
X-Received: by 2002:a05:690c:c04:b0:8b3:2d65:2c80 with SMTP id 00721157ae682-8b5204f088cmr50894287b3.54.1795472754273;
        Mon, 23 Nov 2026 14:25:54 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:83a2:1030:d4d1:10b8? ([2600:1700:6476:1430:83a2:1030:d4d1:10b8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52030d5c3sm51425387b3.32.2026.11.23.14.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:25:53 -0800 (PST)
Message-ID: <ac4e59cc1a1a89fc5d3b33aa481cfa8372562f2d.camel@dubeyko.com>
Subject: Re: [PATCH v5 1/5] iomap: add iomap_dio_end_io() helper
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vdubeyko@coreweave.com, linux-xfs@vger.kernel.org, "Darrick J. Wong"
	 <djwong@kernel.org>
Date: Mon, 23 Nov 2026 14:25:52 -0800
In-Reply-To: <20261120182135.GA2183@lst.de>
References: <20261118004844.3849979-1-slava@dubeyko.com>
	 <20261118004844.3849979-2-slava@dubeyko.com>
	 <20261120-flach-befanden-notaufnahme-b0a663466be3@brauner>
	 <20261120182135.GA2183@lst.de>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
 NFdvziOa4FgUBC4X71upsZIoZJeii2V/Jtc3B4g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-11-20 at 19:21 +0100, Christoph Hellwig wrote:
> On Fri, Nov 20, 2026 at 02:48:09PM +0100, Christian Brauner wrote:
> > On Tue, Nov 17, 2026 at 04:48:40PM -0800, Viacheslav Dubeyko wrote:
> > > The helper updates i_size without any locking, so it can be used
> > > only
> > > by file systems that issue all direct writes extending i_size
> > > synchronously (IOMAP_DIO_FORCE_WAIT) under inode_lock.
> >=20
> > Meh, this should really not be named so it looks like its the
> > default
> > completion handler. iomap_dio_end_io() really sounds like it.
>=20
> Well, it actually should be the default handler as it does the right
> thing for simple file systems.=C2=A0 In fact I'd prefer to automatically
> call it if no ->end_io is set as that would remove a lot of
> boilerplate.
>=20
> It would be nice to do that and remove the duplicate version in
> various
> file systems.

So, what's the final consensus on the function name? :) How should I
name it?

Thanks,
Slava.
