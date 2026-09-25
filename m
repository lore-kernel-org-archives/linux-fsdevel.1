Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DC93148C9
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790335340; cv=none; b=p4NlBCZb1EFmsafmRi+XBz++/AGcCUEMi+xH7iGExOO0sv/Y4AeWkWvIs7d70haa6exyolcDa1CBtrAakBztpnSZtSQQJLfYeGnocUGpXpHEIIliW2p/Pk7IPx81pSG21kka/tdIBxVcmBPrQXkufSG+sXMtuBe6gTuIcwrbN1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790335340; c=relaxed/simple;
	bh=S/O5SVTCTUiSZPQyBDxVAe8MBIe69BJq3vJYrBDoK5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAt3P0ItAo+3hY0G18225wJDgma9avBSPbjtoMm3HwcDSJ/qFDzknbPoQSgbx9sS+roLeyd4DxmKZbj+q6oW65nj3b9EkAdEsz3Ys6aOGHSNYh7FXbDv+I2zgMlcya2xvsrWJIG4/WGNaDN9TUBcqXdsLeModvXy9Fb58IkXdWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZHjV+WK; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZHjV+WK"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2df9754484aso2100575ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 04:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790335338; x=1790940138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HU7aE2uFm4Gtxe7PSFefKmykiXC0/W/FmIxLo+XdYIE=;
        b=FZHjV+WKA80wDM3QJpW8twoGwPkvRZP1bVpVUNhe1t+eej2eDdK6OgGOE7MiDgyWTV
         /KSVD/Xcd1wqMrqr+gOESfoW+60mEmPwPBGNynbNBLgoaij/nqj4IzoorXcwx5gyToo0
         RK5Jc+w0jw1F7/0nCgri3GghQ47lTS0kKxxLSsgYXAZF0oYTGs2UEkhYIjWN+BuxDxAD
         uG5DkTyBvVveHC4S1Uiw4dKUsNHrt/gwLjmmM2dhLWqEh7lA45nfZzl2UNDA3F5RmLq6
         1fNclA20ZCJzQIFK2jXXmaaZy/UCousj+/fOOHczYolJiJ1Z2JLU+7C4D7tmN4FoIr8r
         mNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790335338; x=1790940138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HU7aE2uFm4Gtxe7PSFefKmykiXC0/W/FmIxLo+XdYIE=;
        b=ikNf9W+3oLo7g5jOTDpC3MiGCMCe8EcRD57D24SrQqq6prEFdhMIn+MQzAiEpwpMlw
         zlHpS6xnb1x4Olk23wE5GUEfTo17o8ZAgJFkjAl2xNcYHGJLLQ4xIJdmZ9FBTnAauz/o
         fyWXofcXYBg7POzEMTKWd0jf8rscmmS7qn5JW68tjmMMkM7x7uDGh56TSjMTEGyAiAfg
         rNlRMcVPSnHb7Zhgh5XnnmzljTyvHBoMSljGH/4wTvMr4NxZaG1TKjhwR0AxCl8RH71n
         2cIb8RvYCJz+EALKD/Ab6UMC7Dhme8QA77kBkDTkFkCD/cmXxw1zrAeRQdnJThqWbaDv
         CVVQ==
X-Forwarded-Encrypted: i=1; AKwUvBztw2GXUlYup0d/G6uhL9yb0VpDYuKKuv5ELVR2PrDJW6CE2G5Ur8FRUL6tbi85GbFbHR1+AlQeCDeFZL3X@vger.kernel.org
X-Gm-Message-State: AFuF++ny6PRFZ7K0qS0Sgm700onLQJ6MUHt7Nwio17R3B6agYfTsRv4M
	Rvqc3VoOAGFYj2BJeSLPeBkLR3El8mdhRoDW0MnDHd4DqOhd6YxbTu+G
X-Gm-Gg: AYBFou2psXzMLdnKittPsShoD59iwzAlaxDHw2Y8Hnx778SmDjsPioJBpkFl7FQUESP
	VC/jxz3Ql7WsCRsr6KzxMhiKTLms39xlY/O8IdhTLkFDtXNxObsfVHIIz3eBS2D+KrfeRVgrlCr
	HUE4UMbRPKbMo0Vz4roooGfmbqmAX9FMQ6v75P2N25Z8LVR8to+Um/wbvaO1VsGfd+ZVF54g/h4
	+mo+2n4tZq6G9C4jyxrFTT+nJ2b0vd3uo6+CK7DOJAJvoqTSDVhaRw/sm/GkDl/OrgxBkMyCRGk
	2zHEyI5f0o+oG2qu/7DLr71e8HNRnPrTxqovntAm+usui8/070yyXM1E1XuWZ2F5oAwwDjtiM68
	dx8AAQiCwp9sI6AwN0FIH7uGLhjj1OAgek9VDn1/c+/y8jpmVS5+ARqH7QW66jOd7uMtAn7dahz
	28+6+zN5vA3To1OAQ6vzz5KgROq8jl9t6x8NnwRFMlppJgXku26Haw4bvfFuYfHRrU2o4Gdn1fH
	JSI599U0YxJ6am0SlUoimUZ1e6CvM33HRmLL920/MW1p2QnntmxVI06qrwy0RHyoI92fX5t2m48
	tXkSDRrKRxSH8VXoChCQw5Jh0pKaY1qRfM4kSWZxx/u9h4xqvxoCzF67Ehc=
X-Received: by 2002:a17:903:984:b0:2dd:ad73:c980 with SMTP id d9443c01a7336-2df7dc4086bmr46620395ad.24.1790335333493;
        Fri, 25 Sep 2026 04:22:13 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df90fbc593sm8476075ad.6.2026.09.25.04.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 04:22:13 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: jack@suse.cz
Cc: benquike@gmail.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: reject short directory records in isofs_read_level3_size()
Date: Fri, 25 Sep 2026 19:22:09 +0800
Message-ID: <20260925112209.911126-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cmlro2xzle2aa7ebflvxhbcv74mea7p6qvxhin6egpdvyzyuxh@s45tpgxdal3n>
References: <20260919222553.3792320-1-benquike@gmail.com> <20260923175215.1577791-1-matthias.goergens@gmail.com> <w3rnunloyshklgq4ocr4jsullzhaey6u7odstfoyhd4usbfppo@m33jyem5jgrf> <20260924151356.3287733-1-matthias.goergens@gmail.com> <20260925043804.2091174-1-matthias.goergens@gmail.com> <cmlro2xzle2aa7ebflvxhbcv74mea7p6qvxhin6egpdvyzyuxh@s45tpgxdal3n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honza,

On Fri 25-09-26 11:28:18, Jan Kara wrote:
> OK, thanks for checking! BTW how did you do the check. Have you've downloaded
> all the images?

Gotta use that 10 Gbps fibre-to-the-home broadband for something!  But
no, I used a script: archive.org serves range requests, so it fetched
only the volume descriptors, path tables and directory extents of each
image, about half a megabyte per disc, and parsed those.  I'm happy to
share the script and the list of images.

> So yes, just keep the code skipping empty blocks and I'd just limit
> the number of sections + empty blocks to 100.

Will do, unless Hui would like to take it.

Thanks,
Matthias
