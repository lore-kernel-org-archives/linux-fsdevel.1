Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE174C6F06
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580063; cv=pass; b=QhbCMoVu6++l1Caf60/zn7HA/Nf6o0GHlNZWFrJKJYT6jH6ZP+Kg1jbiUsZGZaXhmPPk5pXMu3oNSE/i56ASNV5XKKShvtD/VjPI771AVUdMFHFxxhO6mMnKSNj+Xi8pUtfVMycfkIHBfwBAQbHkx5TqXoOk+iXaZKcIRzv6Fu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580063; c=relaxed/simple;
	bh=OzmR2EceqZl8thCprtMqthW6BbEcxyp93xblOmmafPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+hI98mw6OdxPKpAcguHWiFZ1S690yF+S20UwmAK8mw2E1GDjQ+3JWPI/Qm056Tbg4pLiyEzfGcBDQbtQHHnH4WG+K7crCjYwwXqwIL32u2Kl3PyVtNVigBaiCHgj6CRk2ObR5eBkXl/C4prukFyAvKHBAkVr4pi1Ya67ce2eWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QIA04Sxy; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QIA04Sxy"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64d5a7926cfso4928927d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 03:01:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778580061; cv=none;
        d=google.com; s=arc-20240605;
        b=WNiQffo1vkOZulDZA7vqjz24R2aO+P2bs+ZZ9LzNrfBuNYLFJ/sB6kaJvbmdzBTc1c
         qrCduPUmeTkOWO6/TKVUbGsjsFMPSCs+U1S1pU3JDReTI1UbzB6o9tjJO4cMupmZJoBv
         YH1VDZFtuhFZMG0VUFtyZpPrmr6q/SzkoxVD9/3n1CHjdKyaGJc2p4HFfQ+/WqKn7ij8
         2AI6di5A2OyWRW/RuQxeMor7hLTnB5XRwS/bgSTYmsJIGgXSlYhGCgnS4HgvwwTYOpbe
         6RJ4jtoHfoz+6xdmIdlyzTkNnbhAvUNzBL28FSYPrpFBaw54He3r7aHMNxyQ38SWx+O+
         E3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+2cAANG65P6m/2dMkcD/5SXbjFJGHgOXwKiLtBmqwqU=;
        fh=cKcAUwP1cKI5/VHr25wwo/mOcykNiY8siGyWzbLlDSE=;
        b=TFyUXnBlmhtlGzURXRnqK6gDjrHuhwdGnbtcus3UGTvNUu0MH050jEqN6YVKBc39Td
         L5AYIt2BU3Yr89yOJ4cW1LSNaZuwB4h6dfT9QbQ7/zNABAGMVZal86na7LbrtXXSfulI
         iGDoqAJUSPj9XkmgWk9HuR3SsAUMlHLbZktN54bW8m8UFYraPo/f5+4TP+R1/uBwRmDe
         ML5QD6blax4ZzcjkfiPvlzR4/yCKwid7ytNukvSnUs4nWcESWXotvuNl60kEKN1GovPL
         8ybjSBKNEY7TF6+qXVPEMZFMDySz+d6YGtcd6W52XsS7FLAufx0sRAtNHS3xT+uGjDNG
         9w/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1778580061; x=1779184861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+2cAANG65P6m/2dMkcD/5SXbjFJGHgOXwKiLtBmqwqU=;
        b=QIA04SxyVE/qv6ake/EWsfMvh/gcjJ2jnInF7tPIPNr8PMKMIxVDrQA7o9eR1MiT92
         filxuOMbNTlNL70CPggeOGZT4CYQVHd4WnvX3naeJVvr/MB6+LksKqyz0/iYceXtrwbf
         zSiQjfzivUuR5uuUDPaS1ZFzS1LJ5YQvFW1c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778580061; x=1779184861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2cAANG65P6m/2dMkcD/5SXbjFJGHgOXwKiLtBmqwqU=;
        b=DPhy9ylZBWvlz7UgLMMPwIQUceciKQ9uvDf8CnamCfhV/rxKH6YgJpxjGoabq8PeZ4
         gHHgoWF4tzo8t5x2myaWHaS5lb00DC/Lnxfs6no1a0xx7YgoN65IPo9dmoWn+YNu5l8X
         oic1epuo4zTQBplITn8+bwHJ0ua1T6XfPU8V2ctnQgr1SevrFw0d+BAAwUp2RGX1NuB+
         IQ+baVloNiYti3fdXIPSKsOWly1rZwS0sVdOu8/cWzGswmQ/whzSkDd1fITwU5p++a5C
         WNI/UiAy/fdiuzll/98akr9hYGFzuyG8u4gIpUe7lgePORn5hd579qOfDr9Pygnxk/7+
         90+g==
X-Forwarded-Encrypted: i=1; AFNElJ9kaBbEDooju/2jNO+aB1ETXpNNl0Y6BOEF47jLdm5tkgw6u8XuGarK6jWWYvCIfSJtw/A3TsV2yHbcp7AI@vger.kernel.org
X-Gm-Message-State: AOJu0YxYSgve2wkD+VruhYA3VGf8vz6VT7F7gyNudxtyRWm6kBsPdyq+
	tgFGphRaXZpQkN9M+9tpjMQPQ1+Kat7OOEfdq4NxmVRTqJh0F0FdS+4SM+fCpx8PKAvPVXm/JYP
	T5X9fSDm6zlINxaup6Yma3cD73JYOphd+rIIREdRu9w==
X-Gm-Gg: Acq92OEMMNuzGZnw4jIhhlPY5fVnsBlO5gQPlZx758yZ+yLmg15ghNQCPE3dUoDgHlA
	LA6mFKo6dbNcqak5k45PrJjRAwnq+5pfbzeyibXGWX8Tuc+Ji2ROgC0vdxJSEXnxbH30nn+fSrS
	Drvo21V1PUG+cbwwyr9EhF9jQCyZzLBKXmIn407IGkI+UIO4fu/TvHZKXUBVSqoTe9NxasWAyi9
	vePQoS/oYyuNgb1FFV5DqpIQA3EBZaZlrut/T4MDDH1pbMNGiin56kYxc4rmDSn2sp+r5wZOf47
	zgby4JniTe8HS4t7hqKCphPWaxob06qgNoTGL2ACLNjd/41JVA==
X-Received: by 2002:a05:690c:e646:b0:7ba:f712:95f6 with SMTP id
 00721157ae682-7bdf5d99656mr202158237b3.3.1778580060567; Tue, 12 May 2026
 03:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
 <CAOQ4uxhnOEkX4qnn0wHMCqWhEeAGTR9rxcw5u_oqGUovuszo0w@mail.gmail.com>
 <943cb464-78f3-44a7-92a7-57a1fe4fbc10@linux.alibaba.com> <CAOQ4uxh4yKEBdgbkfZTVyYM1P8ahALFVJzQCj7ASkrH746_4xw@mail.gmail.com>
In-Reply-To: <CAOQ4uxh4yKEBdgbkfZTVyYM1P8ahALFVJzQCj7ASkrH746_4xw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 May 2026 12:00:49 +0200
X-Gm-Features: AVHnY4JolkvdzUP6hf73qCIiLjxOWc5d-oU24VC554xpuxQx6bkO6OQqR7vJugw
Message-ID: <CAJfpeguR=x+Kf7jd4zyeSoUtbjaPRLhXCRh9wa3c14x+M77kXA@mail.gmail.com>
Subject: Re: [post LSFMM summary] where is fuse going?
To: Amir Goldstein <amir73il@gmail.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, fuse-devel <fuse-devel@lists.linux.dev>, 
	linux-fsdevel@vger.kernel.org, John Groves <John@groves.net>, 
	Joanne Koong <joannelkoong@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Bernd Schubert <bernd@bsbernd.com>, Horst Birthelmer <horst@birthelmer.de>, 
	Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 09:53, Amir Goldstein <amir73il@gmail.com> wrote:

> The problem is only with  fuse_passthrough_mmap().
> Depending on the workload (?) mmap may not be important and
> we could fail if trying to map cross-backing-id regions.

mmap(2) is the main entry point into famfs,  so it's very important.

That doesn't work with "traditional" passthrough and needs to do the
DAX mapping that famfs currently does.

Thanks,
Miklos
