Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6335CB9C
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988058; cv=none; b=iMLtNbMZ45CHO6t9SzpfFvEYeiUMHPW0UoXA6w/tCPIU38kzsHw79F73Bc79u2eweJ0Z4TL2+M/7LUPPXv1kqZEDbx3Zv22jOdhBcn64CehJuUUnNHzhh7f3GJ9b7Z8W41b3i8ZR+TeTdFE6x28K3GvDIX5uH/8nEHUJXjkfqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988058; c=relaxed/simple;
	bh=LTyWv+EqnRpzWRiHN8BmIY8YeqMQ/7r2SQDlQYpP7tw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=XhCyCx8BNwoFrICRzXPuah+WLz7MXbibEq+qmab9gN3feiLF0Es06oGnoDZkGYnMfvGJRngfoJ5qlaJ4b+plT3KlOrxn1vItcm8gT3qzKP5YKxSCIlD/ZH2j3QzPHATUcdklO70n4/3wsX+vdsUvXLO34VFJ6bhzKLvKVZcO2wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=YWLyoAby; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ib5c1KZL; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="YWLyoAby";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ib5c1KZL"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D7659EC024A;
	Thu,  2 Jul 2026 06:27:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 02 Jul 2026 06:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1782988055; x=1783074455; bh=Wbhh7YmTxsvtssy2kpO2Y82zS07yzWzoQIU
	g3qqyk2I=; b=YWLyoAby8v2Jo4wMj5tIAc1WwWe7PFhmdOZg7uJELwx22eL5/IH
	u1B2+UIf9D7j04kZVMEoBAnfNi2PX35BryvD+uebtbsA1SG5KPYwNB4vpYwKdSAh
	nEC3iOXT8wJydX3jIb75feOqBu0UbSBHgW1Li0SUg48rpBK/xiXy/gUhw0TqGr/d
	1W5mv27RmpviIuufGWhBMqK5tJxlma/UIM+ZkWxxWTb2wqgV85OSyyPFVOUo5f31
	JYqj5V3o/F2leEIXwv9iKyDne25y6kOP9iRVJsA0J7gKSCqTc98x9hyJSzoy7N6Z
	mdteqWHffWZygaPJErB9lcozezu7M3d77cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782988055; x=
	1783074455; bh=Wbhh7YmTxsvtssy2kpO2Y82zS07yzWzoQIUg3qqyk2I=; b=i
	b5c1KZL9+5vcr2qECEIiy+Jsfk7dKc9xi98E9TdoO4Xot88SiEEZLbRienYDO1b2
	MQsD6w76imy/9tjff636KepzE/Of8giEN9Lg+J9mC6XzMw+q4/rCXZfl3wklIliu
	Eg5iRhKeRtUXASIeEZI9giVZmDd3BhBcFI2BbnMvCUpz/7hWJ1Lbmz7UCl7K4lSR
	6UDJcGaU6q9bpDZyLzCXc6RN+u9YktBvdPm1Q8GAXRqbGNNNFy4SXI7PIFSqTuWn
	Px2BlwAVXhhQ+kToRfBCTG1D4MVK/G4AdkTbGG907nQaLTrb5r9f36rzaSNtVhbA
	Bdb6eWJ6BMBZgVc7GplqQ==
X-ME-Sender: <xms:Fz1GamdmjPFG3d5SDVj3pxgInvKce4vAAq7CysAa_YDPoUc8XXTTDw>
    <xme:Fz1GauAx3I5qVOGai5Bn2NpW6DkCmSl8Lkb96AHozY9XckyyPO2rPzJyerKu0Xibc
    vfcwDw1l_iUz4Wc-X-jMDIgQH1Z1aATtuT-UK0b7jsfX7jL2w>
X-ME-Received: <xmr:Fz1Gah-yUZDmjkeONwWBlERjfpuib9ZJ-jKQlY3Mju729dTYn4BEKxDH6bRsZvbiQpiGbKfvpYvCA2eI2Uf5zx9HMwwVMGQ>
X-ME-Proxy-Cause: dmFkZTEHbsi0GF6dHfYQiH7gLI69I4DgvEAd5EV+JduwXbkX9II4iPP+98fm2DA+yHG6Xc
    cy8npjXwPUVc60+X8RoIpAHhNKgBxcHYvd/NHx+nHbWQz0nIZG7/BMzW5fz2bh0qz53Yb/
    LoF7wtlT6peNO+G3x+Yjpi/2NEuGVNJOKTTgjGf1rM6kfUifGPCB51KULQxDTCGRLIlXFR
    8BP3r5WjgEpo8LEJRT88nB54caWg7yqKiFNQXnxKAlumWFuFlsRavstwK9Z/reCBaLQ9e/
    VkrPeMZ7vXMUvGNwC0nRDjNDOoDVYYti4oazA0q0kSF48SE+Elbh0lDiu2v/gpzlxfNJXe
    Wd9n8WTWSSkL0d86kZEL34ttTVLs/TGBZ/xpn39GejwqiSoKvZSlbAx6x4u7h9O3W3grj7
    p2hlaDopKmdQ9ijv+w6u9Fn5vj1nSIAr//BKWbleXOKVpkJzto8l2i5o3pcuPP38xgemkz
    yb3kIxZN4bJyQsGYfPCfE4YD1YTBBkL9xRtvh9CaiKHvTVWyDGpHS8gcrBOa8EGMYLT6p4
    2cKZEurDBOHLwMR/fJXsB4Cc77sQa8Dptdiuya7JBpvxysT0vqdvACchV5vVl35kIE6k3P
    jBFcT+/9Wuor5xrgGnokOX7f0iwCt9Zt4/yN5eNF/2iCdRCWTBS//jx8GSGg
X-ME-Proxy: <xmx:Fz1GahL_-j3OijziQ6qOzHqbqqXt9wt6nDVjb6cqemWDWcWpm5KR0w>
    <xmx:Fz1Gaijaiy1kJiB1OsrF8IpLH4jHNZB6gdDa1exB6f7QapRcKiPXRg>
    <xmx:Fz1Gap65mPK8WU_q7kihyqBGuMQQI3R41b6mPGTPKHc2lZYK9bR30w>
    <xmx:Fz1GaiaPhUaF5q1K3alBTB3bpeMiBUbXwpu-XzhzUWIcpe06RE2DpA>
    <xmx:Fz1GaiE1T92wb9d5-mwrdSjHYJqPdukjzDXa1gvcoxwkh0D8yQgSelrf>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 06:27:34 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "David Howells" <dhowells@redhat.com>
Cc: dhowells@redhat.com, "Marc Dionne" <marc.dionne@auristor.com>,
 linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] afs: use d_time instead of d_fsdata
In-reply-to: <140096.1782983370@warthog.procyon.org.uk>
References: <20260702020350.3403907-2-neilb@ownmail.net>
  <20260702020350.3403907-1-neilb@ownmail.net>
  <140096.1782983370@warthog.procyon.org.uk>
Date: Thu, 02 Jul 2026 20:27:31 +1000
Message-id: <178298805168.27465.937804342736897811@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 02 Jul 2026, David Howells wrote:
> NeilBrown <neilb@ownmail.net> wrote:
>=20
> > afs uses ->d_fsdata to store version information for the parent
> > directory.  ->d_time is arguably a better field to store this
> > information as the version is like a time stamp, and ->d_time is an
> > unsigned long, while ->d_fsdata is a void *.
>=20
> Might it be better to rename ->d_time to ->d_version, since that would seem=
 to
> be more in line with how it's used?

Maybe.
 fuse and kernfs store an incrementing version number, like afs
 cifs and vboxsf store jiffies
 nfs stores whatever the server provides, which might be a counter or
   might be a timestamp.

So d_version is arguably slightly better than d_time.

>=20
> > Interestingly the value stored in ->d_time or d_fsdata is u64 which does
> > not fit in "unsigned long" or "void *" on 32 bit hosts.  Maybe that
> > doesn't matter.
>=20
> Hmmm...  It looks like NFS may have a bug here:
>=20
> static int nfs_dentry_verify_change(struct inode *dir, struct dentry *dentr=
y)
> {
> 	if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE) &&
> 	    d_really_is_negative(dentry))
> 		return dentry->d_time =3D=3D inode_peek_iversion_raw(dir);
> 	return nfs_verify_change_attribute(dir, dentry->d_time);
> }
>=20
> dentry->d_time may be 32-bits, but inode_peek_iversion_raw() is always 64 b=
its
> and i_version is set to the 64-bit fattr->change_attr.

I wonder if there would be any appetite for making d_time (or d_version)
always 64bit, much like i_ino was recently changed to u64.

NeilBrown
