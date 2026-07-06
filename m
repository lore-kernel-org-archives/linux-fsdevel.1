Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ED83AEF36;
	Mon,  6 Jul 2026 05:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316213; cv=none; b=qIqf3xIvYxBuvdJ88qwoGmqgS2oaxTHjOxlWC2wb2oP8D178MeOxDeuwbeL+ti7Lrqvu5H1+AToGHslPmRL8q9F3tr9ZydxYj5V8+SMIJAM2ujnY8RGQZc5wlUGiOjdmFK1x3Z4Q290bgdWYO4n+ZR9cYYpV0vWIp8IxnMXmN0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316213; c=relaxed/simple;
	bh=phRdpyZYVxLz8cGnmsWEcOKFOrHK1Z0cJHXGlnyzn4I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EnCEpTw7KNUMeW2lqieTQ4FsHEh/dQ+VlKun0w83mUmTU8KR1NKizyVwfBsXx2MF3IRu5JZH/k/cG7n3LM9xHMGdeU7haaMRALdrnKzQJ7UHxvigXp1c2A2e+SXCB225QPVd6s2UdZVspn4I9i1jJnM0UYSPdM09J5KgY+4t0vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=W1Hw9DTE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L8i4KcXP; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="W1Hw9DTE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L8i4KcXP"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 730697A00E6;
	Mon,  6 Jul 2026 01:36:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jul 2026 01:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783316211; x=1783402611; bh=EMpXIeDICev6GGpgZvY69CmL7ap3l3x5Emk
	dpfxRCl8=; b=W1Hw9DTEXUUJMrtDm3i0I9R6ghrQxaTbnGb1vG9LubDYkVWKl7H
	skXEX5QHtD7zA4HGx1dUme3mWF561kxvSmmI53GjUGKSdmOXAAf0b/EhZqYoPQSd
	uvA1l+2LEeejZUabDy0g9EGYGkCrbNTstYjyArE4HhPotgtczbImBPcIS3maRghJ
	x7MH9YDBFydrFU/wFhluynGyKCgIygp4bgIf506dXt1gybIXxQdAHdEVjR3ztIQK
	Y8/sb9OdXMTJqkhNTPU25RzerF7ELQaMkTKoA62fU+dnG+yI7DvnyskrRV0KDqV4
	4G/TgYg+3vWWhsdxUJmt2qosbsYn6BTWNMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783316211; x=
	1783402611; bh=EMpXIeDICev6GGpgZvY69CmL7ap3l3x5EmkdpfxRCl8=; b=L
	8i4KcXPqZqWci3x5m5b3DG+rvpQrmbJmjLGuA7Eeh5B8T/NRJW5smYSqidvwiVoB
	RB501S9Rd3M31aPoJwVsKPNBl5IYJXH6S/HHZmUz6vmwz0qjdsogaFHyHFQDA/Qe
	PFNh/0RZyQyhmp2NWwyDXKNps5viebdGEU6Tj/BdVP+Rd805GGz1IlipJpZznQdl
	iHairfAtj3ExupNAhbdfySCw9qQaIeQ9e5mCXvpJZRzISLAqhSsyFQnAwrHHvYk3
	Eal0M0AeI/uN04UF4ApOji/ZfojGhjaQw98rDvr8TWLU1C1zuSB/UnHN3HruvFeM
	T54TzPypg3hY9ROG5l0QQ==
X-ME-Sender: <xms:8j5LauGvNiDdiBURmfBooUFJtP2IXQhP1JxN2IATiEXrXNvBCoPNFQ>
    <xme:8j5Lar7vhJJ8vQjBvbcQRnSqZgl_wuzh8LKkq18jotEFPt3S1IPtQ2RLCLHljoqTq
    xWGYWruHoYzqGtPypGVHSqehWNGs_zkKN5gyQjhlo61MZkL_w>
X-ME-Received: <xmr:8j5LaskAzQzzI41izwjnAa_WZRykQMybzqyGicmFobUx8oaQsO6-x6oQk_QZs2fOj66KnoqvfOtQFrXyV37jg0_t5CdEkik>
X-ME-Proxy-Cause: dmFkZTGxLkexdVFSYJuHepiCB1/U+fTbh73SKh4HGluxF87YrD4mX4Eds6e/mToXOZ8oKT
    xGyGkRiokwXShKKpu7rqIV2PNpgDNZONqA8noYzDcP9+lfvwhQrtDzzuAIh1EAljl3tgrP
    v89JoVOoaFmM7aBkp0fiwYHoY/Kzl3cua0NKzXyjkbPC80hUuj7TEBZzfwT42hBUXbUV7T
    8YWQugd+/IA5wIGY314atOJhYV1YRAoH1KpRkpABJjT6pww5Xup9EA2A59GsJTN6FQRYt5
    hEmS0eUgcdhzEZ8DaN6TBmefOCYpO0VZM8DKnSSv40gC9biV3oWOFvvRgst+7Tbvd4WqO3
    ieL1O7rUaxx5iRcvIucHqHiwt+V6wfTeY7z6t5ZCPP+i78ZhEwp0dW5G51DFC06q1BTL5z
    c/6TrZkuJsK6+ha4Q3WQvVolS1CnRWi0quXjKv0XpKvApL1X/hWmI7pyZIKykFtiXkYZHa
    TmWkbR2TVpSJbFKFD4niFr702fj7NUimDmgE7b4BPy/zD9WUxbcRmJoN3XGQkhwBF0Z5Sj
    wEUQCO8h9/e4Qr9QOCPbhlCbduKWzUho4oyJTPXtoXliNcGSvKiX6qP3YLO945F31LA+YB
    +SSO1Sn+s8vdQWHhyFgrFg4vJP8TOzZVQYRYqVSrXCgsdcWaanfz9dfQk0Rw
X-ME-Proxy: <xmx:8j5Lau7svtnAm3SXHnm2EupK8hdFcueFkgHew61rxIBhobLY8q8_Ng>
    <xmx:8j5LalSNrmoZ_AKy0pIBZUagfZH_3zHzdm5J3ef7_zTAYJXppBfW7A>
    <xmx:8j5LakwcvjndhOt5IEV9w7VEVe8KTRiHF14og93k01zFL7IK-N-G8Q>
    <xmx:8j5Lalq9LvUvE0Fey8mXXCcE1G5ta6E6pB7ne2YLjKtn9aTPISiUgw>
    <xmx:8z5Lau8SMISN7v3pWvnVwIZA-d6zyPv9b9KIeKWaSDyEscl1aGuoOwOd>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 01:36:48 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jori Koolstra" <jkoolstra@xs4all.nl>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>,
 "Aleksa Sarai" <aleksa@amutable.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jori Koolstra" <jkoolstra@xs4all.nl>
Subject: Re: [PATCH v3 05/14] fs/namei.c: update docstring of atomic_open()
In-reply-to: <20260704164149.3480051-6-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
  <20260704164149.3480051-6-jkoolstra@xs4all.nl>
Date: Mon, 06 Jul 2026 15:36:46 +1000
Message-id: <178331620622.27465.1385795869903355470@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 05 Jul 2026, Jori Koolstra wrote:
> The docstring of atomic_open() contains several errors:
>   - It does not return 0 if successful.
>   - path is not updated
>=20
> Fix those and be more explicit about when FMODE_OPENED and FMODE_CREATED
> are set.
>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 956adcd14c4a..88d56a470832 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4355,17 +4355,24 @@ static int may_o_create(struct mnt_idmap *idmap,
>  }
> =20
>  /*
> - * Attempt to atomically look up, create and open a file from a negative
> - * dentry.
> - *
> - * Returns 0 if successful.  The file will have been created and attached =
to
> - * @file by the filesystem calling finish_open().
> - *
> - * If the file was looked up only or didn't need creating, FMODE_OPENED wo=
n't
> - * be set.  The caller will need to perform the open themselves.  @path wi=
ll
> - * have been updated to point to the new dentry.  This may be negative.
> - *
> - * Returns an error code otherwise.
> + * atomic_open() - attempt to atomically look up, create and open a file
> + * from a negative dentry.
> + * @path:          parent directory path
> + * @dentry:        child to ->atomic_open()
> + * @open_flag:     open flags
> + * @mode:          create mode
> + * @create_error:  return value from may_o_create()
> + *

 "If a non-error dentry is returned then : "
> + * If FMODE_OPENED is set, the file will have been attached to @file by the
> + * filesystem calling finish_open(). If FMODE_OPENED isn't set, the
> + * filesystem instead called finish_no_open() and the caller will need to
> + * perform the open themselves.
> + *
> + * FMODE_CREATED is set when the call to ->atomic_open() actually created
> + * the file.
> + *
> + * Returns the opened/looked-up dentry on success or ERR_PTR(-E) on failur=
e.
> + * On error, atomic_open() consumes @dentry.

The rest looks good.  Thanks for doing this.

NeilBrown


>   */
>  static struct dentry *atomic_open(const struct path *path, struct dentry *=
dentry,
>  				  struct file *file,
> --=20
> 2.55.0
>=20
>=20

