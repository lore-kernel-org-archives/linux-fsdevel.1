Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA06030FF36
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580493; cv=none; b=hakmJqNJKSeGuLa2jnerMksGQ36b0fRqNRiEa6iaUn1eFJBWyPU55uQc74+oR7BWlPINgQ12F91KuYB5ukNPYPn6u3BSUsrhlmyx50gvu8KtY/0Q4rpdo0ABenv82XExDin7tNlY8KKvLcnAuVZh2yulPBdzYwCOVZ7vw9EMeKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580493; c=relaxed/simple;
	bh=DZEBm7AqqCnArM9eNi1XRjIHVWMaI8eGfrCgZqmx5vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLwZyFs9WepAlhZZrSBmZW3+KmfxO/d9LSN4S0boBM2hMabXW1MAluoPDk6u6dtoTQTth0kA+DKgYAd3zN3DYBkYtiCA6QlUxTXbjnEnFEi9qKymrk2snQ9XixH4aO3rwR7iZ+oLVXrVM635Uq7e811vw6F2Iy1EbmSvX6Vtcqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wh8/+rcv; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh8/+rcv"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc79a5bdf9fso225863a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 00:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790580489; x=1791185289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bye6SXDJtZqYyoJ8pMJ9LL8Wd0RgcztWGshO/EITHjg=;
        b=Wh8/+rcv28soGebdBSKzhwOn68goxvLuv1hRTAzaC25X3bk+4LR3vyn6wNS5bB6Lw/
         SYZ/dtiW2vJr/9/5NzMwQrvtUuMWc7BJG5HgPefwbZiieOB7zVsjflE0zpu1t1w1JfbL
         f/1Zk6XfITsyZNYSqnpFyxRocH4ZYaDzA0woOUuyUtPX/li8QQgFTxh+QyZEsYUW06L2
         P9+TIqlSgIxoM8yGpla3NGZorhmjnU124OCf4AwIF3hrb73P8iFzRugadFwz2VTm2QJi
         OZcB51w33G942eiIkaN1CbEvGw1C0rr8AfkhkOv8rsIZktNffD8XY04Hw1HXrpjFJw2b
         lP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790580489; x=1791185289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bye6SXDJtZqYyoJ8pMJ9LL8Wd0RgcztWGshO/EITHjg=;
        b=q0ejUwfusiGfyDciqQBxUr9RhbJ2hswkBCDcsQSAo9kZ9X6GvpkCV++4Et4Gnm04Wg
         Ol/yWAfT9+Ikh+KU3hJolrckKnJmAXcTO1bTDLK6EmRrWYjHNALx6vRjo6rGUgzNQNUp
         1eJK29jnDGMjDqdslBk8zK1usob6SL1IoMlEz79iz0jXrhzcSV+Kjb6LdOSpyOPG9aJN
         WoilX04ScQHPK9XAMiBgFlNZN7o18EDGqy5L+GewWvAT9+/DTu/K/zRDucCh1DObOFnH
         XD7hjqLBpijlbLDk6ZJ0bMC7miMi90gsW8QpEJN3n+FJiyYr1L99Ylp+kJjOSFNJO3l1
         +3PA==
X-Forwarded-Encrypted: i=1; AKwUvBwhAZNAELIMAGuTg+bBFGKf3LjAltUxOwvBnjaAnJSFpGYnJVtiF4GL4Jfx2Ogi4S8az5ErhOvOIOvamILH@vger.kernel.org
X-Gm-Message-State: AFq9FYLVoNQHCLO3B8FCHHiI2UTfs1p4jrIgg6V7SBYe1zxtIOSVXDZa
	bLK3iikgSr03QWDU02GAGjlNLs8Uq6hIFxJRVAa3/K1I5d0HNFUwOr8OSeeZNg==
X-Gm-Gg: AYBFou2g2VTpyvyKepVl46GTTPevwJHPZnqqNzjmCc6SQqDY/RiunHjLjlNAFKubquX
	FRGHvuBh/8ZnqVsq/TSX5CCZiy1A0uZ95TybUDawKH8mqoRnzB9XjlD2k/P/edlsfgks3/EtofQ
	Usxz+yCOqSFy+fk99tgssFV4xd76qxi7ljViXWp8LJxQBTISqzOuVUN2BcvpKYmTSD46q9qc2Jc
	f6OnTn5gUEObfCuXMKfAHX6x/7yTab12RXSkZeFkH9Q9c+RjgJktA0A70emCvpX0N3Pg0kaTkG0
	soQnPsfKe8U/1MgeBPOzUPsn33s+zuU8Hatx31paZK2+e+cBNh9dapfUnO89hIQI5kSGRAY0H2x
	xyqoahusKjR6bYrgASYXvHG8rJ//2HmIVNxZtdXVYC5xe3h3+s75GiUUK95Qu85Y8aZyS5zqQ+Y
	xAvl7thmjGQEVSIse9NFMi+wYZKZvVV/ngsiZq+pWFrdSirqyPu1E74PDOBt2ZXZ6cgac+MO8hI
	/OBAPYzPYs=
X-Received: by 2002:a17:90b:5247:b0:39e:6c68:fd8f with SMTP id 98e67ed59e1d1-3a098b628d9mr7264933a91.36.1790580488646;
        Mon, 28 Sep 2026 00:28:08 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec5dfsm25102399a91.3.2026.09.28.00.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 00:28:08 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Zhenyan Wang <maximwang110@gmail.com>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Christian Brauner <brauner@kernel.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs/ntfs3: keep PrintName not changed when creating symlink
Date: Mon, 28 Sep 2026 15:28:00 +0800
Message-ID: <20260928072801.13714-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927180359.3867508-3-maximwang110@gmail.com>
References: <20260927180359.3867508-1-maximwang110@gmail.com> <20260927180359.3867508-3-maximwang110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Sep 27, 2026 at 06:03:59PM +0000, Zhenyan Wang wrote:
> -	/* Translate Windows '\' into Linux '/'. */
> -	for (i = 0; i < err; i++) {
> -		if (buffer[i] == '\\')
> -			buffer[i] = '/';
> -	}

ntfs_readlink_hlp() reads PrintName, for both tags:

	case IO_REPARSE_TAG_MOUNT_POINT:
		... MountPointReparseBuffer.PrintNameOffset ...
	case IO_REPARSE_TAG_SYMLINK:
		... SymbolicLinkReparseBuffer.PrintNameOffset ...

On a volume written by Windows that PrintName is the display form, so
its separator is '\' - "C:\Users\foo".  Without this loop readlink()
hands that back verbatim and the whole string becomes one component.
The loop is after the switch, so junctions and mount points lose it too.

Keeping it, the first hunk alone already fixes the '/' case:

	symlink target   PrintName   readlink
	a/b              a/b         a/b
	a\b              a\b         a/b

The second row cannot be fixed this way.  A '\' in PrintName is either a
Windows separator or a literal character from Linux, and nothing in the
buffer tells them apart, so a round trip for the literal one needs a
different encoding, not a missing conversion.

Also, after the first hunk the is_absolute block still decorates through
rp_name while the copy is at sub_name; both point into the same buffer,
which is easy to get wrong later.
