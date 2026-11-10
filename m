Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351302;
	b=z1rkZ9FcnhrtQSc6xbbEgGbwgeOGuB2G5XsFboWRYmRoHFnGo/k/uoKJuMtHDklP54wl
	 O2D7ARl03cxyQkditeH1H9qr33kRsWYrmIIiXP8suOzReM5sS+RDbvD4+PZd6VhLJgOPt
	 8DUnveIf5gsPXoj2f5tyvjx6FQJOsWsdqcoi1QJAYvsHlOO6MIDI8e8ImYBmc6dtdi9Cm
	 8p4X+gPO9C7iaxzHb4vLozPn20812abi3lIUEwtnBUQl/FYoYvfBNAaeun5i0Y94moooC
	 yKIdVeRhxGz2K50Xqku4KMv8SCiX9W6aEShmDWr3VvtT9D8PzwU/xSOXoZ8aFFB6esw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=NLay0fAaS8K8zpYlT5J4F/CgngIHcMA7Bk+zXI74j1E=;
	b=ay+68cRsWkLc6w264urpQS7WE1Yd1RP3Ohi9syDPYYzKO7ouYe7wZ1hyGYRxG5R4KhPL
	 WWRhfENsWbndz+CfMhPWi+K4ZOiK3bJH9paAumyJs/oAX5xZGyjTcmz7wwsv5T7Mf4DLx
	 45LQLaYX8+d0RHGyUahvFhOCLmQPxH/5alF23xcC9i92SzUyh98YcmXQmVH8TkqJG2iih
	 3gw450zeq4k+yRNaIbC88x5E6J+jQ1AGALUNF+XTK6rG4xkgKTVvBuZhHf+qR/IdvAxTq
	 oNrMxYsxgKt9jIR1jRa8stXy10xeLmNQ2pnNZE2S/ifRMGFUGJ894zyCyVb9dOSRQzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=b13yqpXV;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634D606A320
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 22:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7634D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=b13yqpXV
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a210470b49so21034845e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 14:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794351301; x=1794956101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NLay0fAaS8K8zpYlT5J4F/CgngIHcMA7Bk+zXI74j1E=;
        b=b13yqpXVA87T0Iqc0WaWkPTbKxiy1PrVpDcBZMEt0b5/aRczxDZhWiwfDaM8Xlm2eT
         Nnbqqawq4BZYFLL9P+YVPrraYktok7z6C2QMPhWDk/i9gLFx5yi7a6HbAPJRZT7U34DN
         lv74lmiiD8OivwqN4w/oSZpl26yt95/iHARkl0Gqs55Eo2QIo0P5jt+XKnHVZdO7R/FC
         IFo8HrmAg+lvLzE/93pQ/HUeRuPJDTakTSZWa5GVwZqHDRr512Ag+R5ZEKLfCPIQvJ6H
         ZK+p1VpTGUXxkE3B+leNfxozI7RYOXMTeWkLa5O2G566Q9ZLqRWaaEXcXYzODt2g3b/i
         B4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794351301; x=1794956101;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NLay0fAaS8K8zpYlT5J4F/CgngIHcMA7Bk+zXI74j1E=;
        b=fBqeCH5bg+RzNM+9vA0W7D/7egh+rloXWeStO7ODw12kUdRcq7rIWo0NXT0tskijCe
         4Svnj2LNTtYUzOGvolHYS2y9svjOPLNlybseubrY8eYS6CClPG78KAN48mufLLb2XDqW
         KyUgHaso0iATwDDzCAiZ/TzsOp295Lj/HJ/GOrohIMiVFFLmpDtjBd4EbNrSorS3eW0j
         Wq0dBV9x63pfL3RkP8hnND4Li4YPaaH+SWEPRpwxoOquGuHxDvtzFB75mjGpYD7zUQ3B
         nA0JLCUwv9a/no1qdfBSwJOmmXMxeZk3ksHdP7aiPN5XaNF22488Xtr86RCd3EtFVpgt
         kRaA==
X-Forwarded-Encrypted: i=1; AL+hErE91E6D6ZEsSkIWkYT1z/7DTyurLAmy5NK0CqCAuDdPpn89RDGEO2NIRY1OWLgk5ozQVjXYy73RnHLA2Lja@vger.kernel.org
X-Gm-Message-State: APuU4Z+JBtTI66YFt3quhab8iZvA5+hFfqtwWHDNbbeIQMqAPLsN1o8m
	+EbYkxy4amCUw2bGm7+AYbyDJLTWsCjYOEYtmUl+QwtPMx13kBjCaNOJ2C04jmo5z0s=
X-Gm-Gg: AYBFou3DVR86PtZ5NjSRIU8Thmdzy3yj2s/x9VKHocLbD5ynzr0hoA/uBZRj1mTa8GG
	3Gn1rtNWKicD5SvUrDNBwpQyEagkkTNo4LMSdyL07k0EQcyW10n8KEv9yENyMhHkSIlStuAAhac
	fa+coK2n7FCZkgpRTOYLCGxLAa4Td3OuW+x+eIBkyvJoK+2cNnI6f6XqfKNfNiIuwEmPvlLdDy+
	oT25EpxjBxkW857NhFRhh5znQuLl4UJ5ZcgwLUGzcR44AsAKgmHmZvnbcGmwXkA87TMzMIdR+z+
	Yq4B6VIPIt+WKfum3LzV8Cr/TPXFqjZsCFXPSbbISsG97J97ieD9qFL5wKogXT11Tj09mgJA7IU
	+xOlxgeQKmHLLAe1QEd0WpBLCzvNVEO7UOmEGmlLR9/r2JZMPLCh1UDY5WYdoVRaGoSLrP9Qmv8
	DQmxFL3ihnsjwXi92q1WaujROB3aIaSHZ9zWcIkRhGHfAnPNXS37v/FbhJbc7eOimyRDgo0uykY
	wxjxACQvkbsUg56KWXaL2/R2dsCMSw9yB+UH41fwEJPbOT+gahs6k6Asa4QXz67dpjBELcyP+Uo
	/5XJE6eQioijfdEhAaroBQ==
X-Received: by 2002:a05:600c:3c87:b0:4b8:fdd8:f2c9 with SMTP id 5b1f17b1804b1-4ba093c1c0bmr7546615e9.35.1794351300895;
        Tue, 10 Nov 2026 14:55:00 -0800 (PST)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaae3e582sm1412409b3a.39.2026.11.10.14.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 14:54:59 -0800 (PST)
Message-ID: <c5c47eed-c927-4ee5-9841-7631674bf6a8@suse.com>
Date: Wed, 11 Nov 2026 09:24:52 +1030
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/34] btrfs: check BTRFS_FS_STATE_RO instead of
 SB_RDONLY at runtime
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, exfat@lists.linux.dev, linux-mm@kvack.org,
 ntfs@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-efi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-xfs@vger.kernel.org
References: <20261029-work-fs-sb_rdonly-v2-0-2f44f64f0b66@kernel.org>
 <20261029-work-fs-sb_rdonly-v2-23-2f44f64f0b66@kernel.org>
 <c88e4e9c-6b86-4fbb-94bf-909522badf83@suse.com>
 <20261110-kursniveau-zeltlager-quintessenz-36b26debabe3@brauner>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ujyBQkUpLw5AAoJEMI9kfOh
 Jf6o8OIH/0mqW+TQM4m2x3hCsnK+oB4yJH1qnGvIhFF/Lhs48wI02sGh6/4aA0hkCDfd9LHQ
 +ci4FUepZ9y4VS01+oIExbg/8ytzGYTzLtb44jK2GBOBVSJkMiha6jp22XFt7WUkT/tvbreu
 WWdGsaJIRQaZChy7xsMI8lqQ2WdmluZJ4LT0wD3l/l6QU1ZseMGySebdY9sVOQEOJNV7Qj92
 /KOAFNmeZshV/qDI8Iw1RTs6TvLqCcqmlZLCmJkYSVhT1RonWRren8xIRcFEgMe004IDnt7V
 qdQhk/nhTS9x9MBAhMRl0TTE1VKDLvVALsud3iZLrmmtYvwPApzGJk052f0m28vOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ukKBQkUzDspAAoJEMI9kfOhJf6o
 SNsH/1ysUWOKmzY0rGS3ZdS61QgqMGhSWD/EJ4UiPw+xO4l4+GtX0fOAqxqsmBKqje3vyhBa
 Z5o/1Y+gNiN+E6RBcSz4b1TAd78sQ2bvT5DWOvBjeeVxHdiuQMIn4S8xk5ZpySBw5ifjoiuL
 0M33UVtJOzM8yfAeL+d/Rp4leJw72SutjkLyZTG/gJIp4pJGD/kFHn24OLL0IxEcO0gOekNZ
 os5e1R6jAJ2ILk7+MDnvU8wXHcCiVzuDhJLI1tih1uUIE50muHQJWbYuVBbdJeu8WlIDDssx
 UOCxLylNG3gDXV5MhLubPTOpp9OiFc/XC37nvkgEcrlmlOFBv4/NJCbECpo=
In-Reply-To: <20261110-kursniveau-zeltlager-quintessenz-36b26debabe3@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/11/11 08:24, Christian Brauner 写道:
> On Sun, Nov 01, 2026 at 01:26:22PM +1030, Qu Wenruo wrote:
>> I love the idea. This reminds me exactly why for btrfs_force_shutdown(),
>> we have to manually set the fs error without marking the fs RO, to avoid
>> exactly the same problem.
>>
>> With that said, can you also a set_bit() call in btrfs_force_shutdown()
>> to also set that flag instead of the exsting setting fs_info->fs_error?
> 
> I think so. I'd set BTRFS_FS_STATE_RO in addition to fs_error though.
> start_transaction(), join_transaction() and btrfs_remount_rw() key off
> BTRFS_FS_ERROR().
> 
> Note that this changes some error codes after a shutdown.
> btrfs_permission() returns EROFS for MAY_WRITE once btrfs_fs_rdonly() is
> true so opening a file for writing fails with EROFS instead of the EIO
> from btrfs_file_open().

That should be fine. A lot of other call sites also return EROFS instead 
of EIO on a fs with aborted transaction.

And I think for fs shut down, EROFS or EIO is really the last time end 
users should care.

Thanks,
Qu

