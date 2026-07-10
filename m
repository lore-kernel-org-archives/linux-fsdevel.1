Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13051372684
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702276; cv=none; b=sKniM2pTdtH5anKp7oWAipVmhpRYN4wAiRaHJS10MQCV9EoJowFGSWTvz4rDLynyuIWixLt/kEyThhvp0GmY+ddCA7Xvss0VRF2nweOVnu9cFeXLuV6AYZ2LzVb/GTnxk89VdlQn+8j30V8BcYa0RPBS1OSEbn8pwVkCo9N/Ll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702276; c=relaxed/simple;
	bh=3C9xrviMtBNKxoAWe6v5qHEFg7hq3GdyUcmcOzhgc9s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u2YXpMDcG6zf/CZ8IpZ75eFnv5BvVOz4yC/iSwSwB1I8cu+ULp6TQay3hrX+rovJOHzuW/m/Om7g6WpR5gxF0WcTyckfTQP5caLNBEoeqh+2EqNPeHrP++1QV2oRtTnH5vVKxVARd5wBlIPQv/xlwBFQ4gvJJVapgoLe9RpjwCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=HiNBUAcu; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="HiNBUAcu"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66666bad8beso1655789d50.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783702274; x=1784307074; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3C9xrviMtBNKxoAWe6v5qHEFg7hq3GdyUcmcOzhgc9s=;
        b=HiNBUAcuJXC9eibdCs8sARfZaPfL7R0pNcPaWZssueNyKbUIpkiql91swlfH9HCltt
         9PW53K57amIahCMBhRhy19VaqclCnnjR/IomMm1YvBJW3BIzaMg97NlGJWdCr5wi3dse
         FZYpW3MVUegBLMTdJLwJk0HD5H133JgtQxFESmYTLzdivBEpx4AfI0CMG88uiEL9+Od3
         8KFwNBfm9tm5RmdVHteweCQNyeFCOhX3llasD/1bCJp/lHSbjH3cqF5VpCrL62pyit/h
         r+iUsKtx9mnRJ6pwFb5tDanezRw9ZBqr2Ewf4k/p+4bBf2JHyPASbp8Yd+B4nBt9Knz5
         J0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783702274; x=1784307074;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3C9xrviMtBNKxoAWe6v5qHEFg7hq3GdyUcmcOzhgc9s=;
        b=nzMHBEfujEY5e/IO/AtqOhJipCv8Z7aQRWuqq2fGyIBW3FhYhBTwDZbGMItaAc7SA1
         csb9GExuU8opdqzxG5RGR8q07TZob7orpSKqptEQO7FK+tMBUP08o9bltnY2VeVE1Yfu
         xvCwm2RGRZzRkprPLd7iM6bRKcOU8nZiULqMyxYnUqVuOUD40eWNWgXmfoWGI7DIm0HP
         CJwCDDqh3IXc9dZTXn0ytFTDnv4JsvNNgZfpsZZ7hEtIIPBZXLqj9kLOQsy/Bht9jlj4
         tumwDtkE1Hqia8v8PhQMySd2LulI2WVffjq5Q6cbSr6uJ/OBhvEUm+oO8ZZqKfc8Jgn3
         oPkg==
X-Forwarded-Encrypted: i=1; AHgh+RpG+SadhM+FYDQKk7iUzOvjgXhU4r1kfoOpzVMHHYOCmBOadjU/9a0YcKgW6dTiptzikKnLbv6TWJAjZ7oz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+UjvXYfNef7IPny9f2L7tKHeInT7p3i0urkZLWfz259YuquyU
	b4a7ALu0SI8ZCm/0d0QILOx8PPXPd+MVcJfbznmx7ltq7DuLDDJE/tWVRneea7Rbvgg=
X-Gm-Gg: AfdE7cmgBHHOsRg0fWaZzDoViujhcQoZBOmLGfnHuPXASRFlnT1evB8U806/fcVRWYw
	NAR8TpfoN/0MkadZt1fVITpCJZyCbA/Mo3nw+8sIsvBItQnT8zlqb9AcVhMNXATtdZqt2edDEa0
	TeRE+CkTWC21XpC8tBaskuVJs4/qVXmloATXYrW4pyIQfGeBFOTdzYGXw5sbMEkAdjTgqeqju/u
	7XnLnSdrLlVQh9LmAPlEcdlr0GcXxgp3nuDHKTrPFXAmjzI+vavWLp41mihmdC/Gp1zGmEU7Hiw
	xkqwMpW+dky9isIVsuVtPzImne44eQL8Sp/O1DhoL2FVl7R0f9uE51wgM28bGVQiw+PgLeeVde8
	JB57TyDhNyWroBUqtlZJ5KFAF3eyn2c7CJ3mYB2JGRA4JgU2I8SrXiJuH8VClLWpUpRPiuI8L0q
	f9aNpZeMT50Akqc+v6TJxzH7bgCFsObTbv//jrgNG09/MM3LaoWMJtUT3VrR3t8MIsZflMsR0Iz
	eunWmzyJTP8HgTvEl8TnxazgGIDXMcG6fD6BE7xOwI5MrswIct068+oi+DkIGC4opSXI1WR7Zjt
	YqTRgFM=
X-Received: by 2002:a05:690e:4390:b0:664:dc52:6abd with SMTP id 956f58d0204a3-667d7be224fmr68358d50.84.1783702274084;
        Fri, 10 Jul 2026 09:51:14 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667879cada5sm7323498d50.11.2026.07.10.09.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:51:13 -0700 (PDT)
Message-ID: <fea4c4f25afb7711d1e8fbe6ca5ab654ec522186.camel@dubeyko.com>
Subject: Re: removing the remaining blockdev_direct_IO users
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>, OGAWA
 Hirofumi <hirofumi@mail.parknet.co.jp>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Yangtao Li <frank.li@vivo.com>, Dave
 Kleikamp <shaggy@kernel.org>, Jan Kara <jack@suse.com>, Mark Fasheh	
 <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi	
 <joseph.qi@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev
Date: Fri, 10 Jul 2026 09:51:09 -0700
In-Reply-To: <20260710050744.GA6720@lst.de>
References: <20260710050744.GA6720@lst.de>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-10 at 07:07 +0200, Christoph Hellwig wrote:
> Hi all,
>=20
> we have 7 users of blockdev_direct_IO and one of the lower-level
> __blockdev_direct_IO left, and I'd really like to get rid of them.
>=20
> The filesystems are affs, fat, hfs, hfsplus, jfs, nilfs2, udf and
> ocfs2,
> and you are the relevant maintainers.=C2=A0 In 7.2 exfat converted
> entirely
> to iomap, which would be a really good example for a "simple" file
> system.=C2=A0 Another options especially for the file systems supporting
> foreign formats would be to just drop direct I/O support and reduce
> the support burden.

I like the idea. I think we can try to switch HFS/HFS+ and NILFS2 on
iomap approach. Do you have some initial patches for this? Which
particular commit(s) converted the exfat to iomap? It will be good to
take a deeper look into this conversion to estimate the complexity of
HFS/HFS+, NILFS2 modifications.

Thanks,
Slava.
