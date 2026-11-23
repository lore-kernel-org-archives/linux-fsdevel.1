Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795443551;
	b=jmBqsAxo4UcKeXVH9uJp4HDaVsz7etfaWo+Ic3JH46HrkSmCVDV34NPvmx+kYT52Rp30
	 v4nWN48Tn1QW70ZorrcVfzdXIzFtjItGHXTjfyiqoABy+hnyDsKSiZhXg3xCfo48Alqpa
	 ZYZITPw95zjxviKbd4L1mxHphEh41w8kpDY2j499C+2DWz4EH7cVyzhTOd6xKglu3s1lZ
	 fkGjWnbFzNmznMw9ILYPdsyJdUImtaK1LMieo5Lx+5sTaZwAoFQc0lJxWt7KDC7Dy2c3Y
	 ClA6A9HAgX84yv4fEFEHdrdVZx4BKMr5i8bmN9H8f05Wr9RPJl0ETFXv2udUJt16T8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SGqpzMMXOxhLnysXHPX7ervAuuBOMpPxjnvIFfmSlbo=;
	b=v1BJcbjmNyZnXMWr4ywwZlmxMoTa+2vZIqrO9CCDemNtUzhdqlrqd0C1Of0/phIEuE7K
	 nXb+4yRsg4ujEU7ybEnfGTJfHpdOZSlxIqu+5hOylxyKEcXUqqiXKo5Rpo+YbTz5xETXp
	 bNydN5M3LcF8KS9Aw0d3o28pclPod5XycTg07vQu/OBnDgWRn5dVfBqelZMyptiJeI5iV
	 o01XPeheGO9z4nDg+5lQyeD/eNp1QgCV6t5C2Io3FagVg4WFCp/ezg3gJp61taNoQSOUt
	 3AGnal7HpLngm9SVUZhsU9voYj1QyUczzjwT3cYmDe6tdMW96+F9JvDsDU6oIX3hvMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ia/9bOu8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E4606A32E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 14:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 884E4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ia/9bOu8
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so5364014a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 06:19:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795443550; cv=none;
        d=google.com; s=arc-20260327;
        b=rcbk/LF4nkswQpdPyXW1WS7hskIT8z+JzY6+WPAQXPfttPiOKv9DRhpAL2GeTi460W
         KDAUSvQChaCTzKi3/8lZIxgaZSds9WoAsUsq9mUa8bJAUcX4AkttbGaFX3LsXwmHGZdP
         El7Dy4Cx+8ynczKNvH4QfY2gyPt5yER5JxH5YfwJKUgSxDOabUs+4AhUbxlit8PNcXzm
         nxTMRK/FqHt5aR5PlkbnoCKF+70Hf5cHFKaJhcETfFYBIaLG8SxI6KaBh+Fx3wopdrg9
         oodNnScnWj1Xr3oZg/sjmUapE4zbYd//Y2s2u96KAuIcLnaDjAZAveS4WChxuyMk7sAw
         sNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SGqpzMMXOxhLnysXHPX7ervAuuBOMpPxjnvIFfmSlbo=;
        fh=7issNb1a+vHnh85G97+/9seiLj0NLuqv4KiHbk7ZUng=;
        b=PS5DrsAaHJjL+UPjpABSjH5BxG/bqa9Weo5Ej4FAUAoummMw/8um8aPsTlfBaeEcbe
         j7jW3R1AUM0QuSu41OTf+T+WfIwoFsBS66DvBZnVRNYT5JdB8AFSUgvfaMSoXTyT7Gdg
         /f5ObZZ7+OA2uQWoiITRIMRCA4A+Dl1MbMhafz8nr/QruZQMqje3AeKdFe1uHhCmjz+w
         gxo/qBcWTUkuKdyN8tDMYAKxvqHWr8FDWR7wBKdOT9ejp8vgL2xaEj14Qee8L9HzeWaY
         2AhJeheouG4MV/eEMtKeHHJM7YFp7AL2er7tcrb2debEAFvxfs1eIwd7qfoRL7CPeAMj
         KLwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443550; x=1796048350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SGqpzMMXOxhLnysXHPX7ervAuuBOMpPxjnvIFfmSlbo=;
        b=ia/9bOu8jSdEcdklu7sre/wKzZoFdki81W2YJr5dws7NTbMa6eVh8vfd8h7EZAJ14D
         zJ0mFNzTG9vSV7EDC7ZzObA4FfyyFHJFmlg2OfQnE1GzlKJYEiaPGS+81TXDzscV3Lmf
         e1X/UPfaxn/OuM29vOeBkbikjniBtlasyUheiBxZBmZndMWZEYV/NoVgu4CKY5knEIJ4
         FHLmL5+7Zqnk0SKhO1f5Rpk1eEaOfaYiP0nRtrE5LwUEhOM5CmVruhmq/q9f3TExFydB
         fjuNhxX5EXWG9T9dmW5z9mMjNIKUvdWzXZN1cU45mM7c3rZLJkxX3+ShE2gwYEV7l3VB
         J4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443550; x=1796048350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SGqpzMMXOxhLnysXHPX7ervAuuBOMpPxjnvIFfmSlbo=;
        b=Vkydt6eLtK98WDW5I3t1j84kSGBG5bW3EkRDp9yIVBLtWSnpeIJZ+xLt4IJBkW/0Ys
         6nrLkt+s1zK64vyS1bRQuFMWwaCowEUCHmPpo335Vq9HYwHarIJxfYHR6fpeLRkgdCnL
         O/EDsSKjlDSvLtyzQ0hNeONXyPYqhgaEnWS4VOIM493XzrCNW7mYUsfV1yJ4VXlqXAHr
         y2vXhXiY5uWb2p4NG4OzuND5jBTZNoSJkN8EYxLWrt7/L+IbdI9Q7SDiHMDVbimA68si
         REzV8XmJBzi4/0SDojCvL4ed4kyZj105dagwbK1FWNiEywJsdzng+4ZHvNAwKNiaAa4r
         ncRg==
X-Forwarded-Encrypted: i=1; AL+hErGoCgELuw5/133kQsUnAL91ZcGNi9ez+6mODfIlgj9Bhx5rUbY9tWocpJODyEitwSv9zLZYywRrarNyect1@vger.kernel.org
X-Gm-Message-State: APuU4Z8zoHODwwTr7ARpMLLA0eysL9aIRgYx9t5OaNRIXSLm3x1ft8ZZ
	3GaEWbDzZ2A1GBd+hFOO/0Yi7ZKQAfp5ocYPa2ZTfeDMxZI73IzNEuE4j7TtlZgfr335a5q69Vx
	GmtWXP+hsQQZ1FohCsYUPygTjzPpsK2w=
X-Gm-Gg: AZFdTZfgBAh88Wd/qMyuh7KvwrwVrdKlZuNl1ep+vydAxeZXBjgVA5l6h9MoeIJXUu7
	ILc1rJZgr4icjBjjwlOg4dozp8PaynFoUYp7c8zpoDzeSDsWp86WzQnAD8kdYy4GrCuq750tUwN
	XgrnCtabc+RI4gNfKRS6olCooOqSHIiinHY/j1EwtguWlw8OZpdxB75TYRyx+Y6yZFRZUwrTls9
	b3ACVcWs2bE4fnJHrLkrXL2z9ur/Wsyy1IACSPdn++ZsSIkmyyytN+RXWm/GmId26ohRPO1TsRP
	eZYh5xJBIfa1OAIZtqPUISUn+3zudm8iZrEdEJYBHFhTQdDqLp3AQjkRoCNY60S9nyhOU68S2us
	wy1FVVU5ePC9H08F+np0dHQ/+ZB/pgyGBL2joUMUMHCbGuXW8RAKEgbMxFxZv76BFzHen1Q==
X-Received: by 2002:aa7:c61a:0:b0:6b9:86d:bb5e with SMTP id
 4fb4d7f45d1cf-6ba37e91e14mr6755202a12.41.1795443549130; Mon, 23 Nov 2026
 06:19:09 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122000856.536902-1-koray.fra@gmail.com> <20261122000856.536902-2-koray.fra@gmail.com>
 <awP8S5KF9v-nqWVY@aalbersh-thinkpadx1carbongen13.rmtcz.csb> <DN2NJH234CC4.2LSWRSOO4TX5I@gmail.com>
In-Reply-To: <DN2NJH234CC4.2LSWRSOO4TX5I@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Nov 2026 15:18:57 +0100
X-Gm-Features: Aa3M54qCw9X0Tb0EaHQOCg1GMA-OBfzeB1bXtwNxs39Fn8cRfeeS4nOAW1KHDXc
Message-ID: <CAOQ4uxiREfVU-WKiUVRZLb-uzMXzDEsmG13FVMW7YBoyq10=Nw@mail.gmail.com>
Subject: Re: [PATCH 1/3] vfs: use goto out on error in vfs_fileattr_set()
To: koraynilay <koray.fra@gmail.com>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Hyunchul Lee <hyc.lee@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Lauri Gates <lauri.gates@gmail.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ntfs@lists.linux.dev, linux-nfs@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 3:15=E2=80=AFPM koraynilay <koray.fra@gmail.com> wr=
ote:
>
> On Mon Nov 23, 2026 at 9:42 AM CET, Andrey Albershteyn wrote:
> > On 2026-11-22 01:08:54, koraynilay wrote:
> >> Switch from using if (!err) { ... } to the cleaner if (err) goto out;
> >> in the main body of vfs_fileattr_set().
> >>
> >> Signed-off-by: koraynilay <koray.fra@gmail.com>
> >
> > Looks good to me
> > Reviewed-by: Andrey Albershteyn <aalbersh@kernel.org>
>
> Thank you, can I add this tag to the v2 version of this patch (since it
> won't be changed, and link to this thread in the comment section of the
> patch)?

You should always keep RVB when re-posting without meaningful
changes to a patch.

That's how reviewing works.

Thanks,
Amir.
