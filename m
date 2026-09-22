Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FBD440658
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067204; cv=none; b=hvA3cp+YgsQ4fL0KVoeWKOUMrCyDf87LWspnHtOqUTgJVvCKIPFeV/fzDZV0UVWLeZK4BNEhR9w13HxNHIoAdP4MvacklI0Z1a9ulWtR6/10N15qLdL7TznA7SPE/FhfF5hv1TV5rqtrL565LEFuMZHyadD6J0UrAbIhPVJc5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067204; c=relaxed/simple;
	bh=cwkQkF8AomV2dnbKJf7T2kOh90w6b9kYZ0Q3BS/MIos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUu7LG2pZTeiYptQykSrwv+KoLhthQmnHcSFXVwk0aZiRbPj70JkxKW/hm3fV0a1oxr93wtvlcyajpD3RO74ZJpSWW7eQ3QzrAdMuyyJhi0gLrafdX5Uf9N3U+aun5OFOxn5mSDkwpLVbpRE/hFuypjDCgAWy2EHY0A7geD+UL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3uYbXx/; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3uYbXx/"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so20862995e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790067201; x=1790672001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0GErKr9K3VAL0iFgFHZZrAHFzNuomMjoi+stMILpMQk=;
        b=U3uYbXx/8vyGkMOwkCoDp5bAjLPUR7AWh0B6hx3lKkSU4aa9YBNuFshTbmkMp/3Vay
         uDMRe9fj63AeYQ/xJSeekI73IN3cQCzJkwan4pcSVs8SFBX33iuytK7FRYf6RmmpS0lW
         pJsyz9k2hItYA0XOQGc8/jrN5SEs1Lz1yvAon15q+qciLMR42iylsMuQhcrudqxwVUy8
         PDotFqE3vGXKJwhE+I4Gzb0En3HBd7mk//jgm4yL796SbW7ISBClWBqRyFWVyU/Bw7RZ
         OdJcyepTOcOsEJuzIMJQ3Pa6VwB8qk2YW27vFLs0K3wUN2DkaT1NT7rt16BegZqDqYht
         VHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790067201; x=1790672001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0GErKr9K3VAL0iFgFHZZrAHFzNuomMjoi+stMILpMQk=;
        b=L9XabazckvBzs6R3VnKBK7KblWCyzViKKlR5kNpIn/4NTdpBWURwlP1/xMIbmqMqQ+
         xNjOUf5Rm+yHVti9nvqFxitniM7AtCmzXEDbMpF7mDUxizEEpKx9vf8yfJPwcOnvvpUr
         hgzl1jrIfqYlFmHQTY2Bx6CO+fwHtPbWfDxLmxyBl9e6Wj/lEsg4fo5sAuIpgbaMC6Yp
         pMQpyLaog7O+p+ItX26RCB6Ye42w2E7KlxmPO290MmCbeVGj8UxOeavW84aF50wKKHNB
         DbunwH4p8GPU2dS51fHjDFx5+urHg+go2ysv6e36B3PlrS6QkvfMQpxRBq0BFut4vwjg
         +umQ==
X-Forwarded-Encrypted: i=1; AKwUvByZKviPX6RYTba6jecD0CUzkJZAx3e36nYj9Ie3jKr3MUQSt12TtyPZEig8TR1niSAAQQuOJzNbNpaDcpo+@vger.kernel.org
X-Gm-Message-State: AFuF++nr1yt4YCuNKlqccxtbzbkdHyfApEA/Yj7jFCGktOltxM9gCR8q
	91Ok0wQjKujP0k5ZZjLNPLwv07Mk6vh9aKcCsc8lBXzkkw1/GNjPe2f7pQ0gAQSTDxk=
X-Gm-Gg: AYBFou3MrR63tDgK6itaCLhJjG4JqE7nHVz3GK7yj0qlaEab7Yu42PxNukf0ihkqXRz
	eUVSqC0mvHtd5kAAlLCC1TTzKUT5yQnifdumE1Fmo9IEaeISJ6TgwFEM016PsvjhUQ0mZMUGAVq
	b60g+4W8P7IEFMDpeUY//anKqcJV784wgqEoxmCZILHSe7C3ddKQY4WmEKMegxrhY9NkEZsaY4a
	Gt2rWDPRXrcErk/YceG2ZQfldDQrMBajyicPCWAwP0/Qt1aaE1ndcgKjzCdIpvwkRXRODx3nfps
	eE0uccTEx82Pf80Pd7nemUGd86FfX5YUrt44YAsGWi0Ld6b9McXERt0Vskn7F9GBSrbjIl6joxa
	Dt6iahDmBDYqtvQ/Ds3nA6vtUjgbkAw6JGh2/jfjZaePu0vJ21AhVXDOp7RtZp43G7f+JASdz1I
	N2icPWawWiZrersroHDllzxXS+yTMM25ZcO/v59uDrUlXfE8BnthbxFXAzsjuW8i5bRyN7QE7Fw
	s/XWcqW7liXiH47lZGOZlV75WbxonvizhaQWSS9Z2myjau3d7knxGDq2EiCogZL457h21uStN41
	7aUO
X-Received: by 2002:a05:600c:8584:b0:49f:cbf1:e76d with SMTP id 5b1f17b1804b1-49fcbf1e9a5mr119933255e9.0.1790067200729;
        Tue, 22 Sep 2026 01:53:20 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdad36439sm52688975e9.6.2026.09.22.01.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:53:20 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:53:14 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] iomap: don't resubmit an ioend after
 ->writeback_submit() failed
Message-ID: <arJB-tAZTbcuPaZJ@andreayoga.localdomain>
References: <20260921083133.2960-1-parri.andrea@gmail.com>
 <20260921083133.2960-2-parri.andrea@gmail.com>
 <20260921222953.GM6283@frogsfrogsfrogs>
 <arITXTsUhrA0N-qr@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arITXTsUhrA0N-qr@infradead.org>

> > Do you need to do the same thing for the ->writeback_submit call in
> > iomap_writepages?
> 
> No, after that the wpc is not reused.

Matches what I found too, thanks for confirming, Christoph.

Darrick, I'll pick up the v6.17 stable tag for v2.

Thanks!
  Andrea
