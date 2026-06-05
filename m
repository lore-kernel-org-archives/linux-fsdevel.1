Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AE35F192;
	Fri,  5 Jun 2026 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653864; cv=none; b=QGZlISj5m494XXDaaF8mpcQn8LvtxXDSRopI1mOK37ytW/foSGoBRfVqverqy7o9+Ug4ATI9l3ahKTkvBiEgA/Q+Z7XKo5GAff2dfcC0dWkr88r3KZu78VGg9RWznz7F56TbYDSiz++oBI+R0AzH+rgn/cr+BgTHJzeb9LTlq/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653864; c=relaxed/simple;
	bh=nA4G2YdHBKRnClhTBiED1u8BdeiYT2sRLkL47310z/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqkFrm44H5ro5cj5yl1MhGeuiZDx1Lpf/7GrWIDPoiarNJlTs9X95221fUBv4bp7aoDnDXou85MSGeFlDG7UwIqQdCy/8d9eMqtEMNT7NeY5GGmEfmV4mR2ctW/HE5iYKU6xX0/LHXOHR8wrQ/J6no6L0D9K8DkqBN4TGWZZ1tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu6A7Dvz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu6A7Dvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FEF1F00893;
	Fri,  5 Jun 2026 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780653861;
	bh=nA4G2YdHBKRnClhTBiED1u8BdeiYT2sRLkL47310z/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lu6A7DvzUzz1AdU9dvBBZ9wJnF1UfKe/iJNdPYiFWI9QZGWplPmkz17Lt1Y6zUsDd
	 V1s1R+RySphO8qTTUZ79wwy8wnsmZS9UzteSzvWyB02Q95Ov2oJSyLttoYABhuLS9J
	 TbjaDJO20PpV1SbsK6IgNRQd2mhvzmZI0PcBoh4A+9nxFcsrHxP5W+AzgwJ8UsOyfc
	 3ufhuIAN2eCXPxB8i8G/he6FhHoNemhD2V58uLJZ5qFKFUy+SnFdetec1y59y7D69C
	 rZH+eQSz67Xje0B1YP0UcllPfYVRQuC3JRBdX26K5yS8eCcM9whO9brR1HNQaZDzsJ
	 sA0ohXC3Of7Lw==
Date: Fri, 5 Jun 2026 12:04:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: AnonymeMeow <anonymemeow@gmail.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [DRAFT][PATCH] fanotify: lift pidfd reporting restrictions
Message-ID: <20260605-lauch-kanufahren-leisten-4b459f3c1875@brauner>
References: <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com>
 <20260604194650.2826-1-anonymemeow@gmail.com>
 <CAOQ4uxgH3Fi3HOCsJJYSEj94qmkS64hskBXJwGj22dEAtG0o6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgH3Fi3HOCsJJYSEj94qmkS64hskBXJwGj22dEAtG0o6A@mail.gmail.com>

> > + * pidfs_register_pid - register a struct pid in pidfs
> > + * @pid: pid to pin
> > + *
> > + * Register a struct pid in pidfs.
> > + *
> > + * Return: On success zero, on error a negative error code is returned.
> > + */
> > +int pidfs_register_pid(struct pid *pid)

Make this a static inline in the header, please.
