Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.205.69.214
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089917;
	b=Lr+SM5Yh/7k8sFjIc7l8IciqeUkdddLy1eunpeoycGtPOiL1n+eqtGE4PLZ1lp/E3UQn
	 TiQEqFf4Qi4GuUwiJzyMDRzsOwV4xjjdI4GgLh69TgmTH354QzpmoFXzI/+sUkHnSuHpw
	 VKaiJsulpIWlDmdW4iy5hW39m43YV7JQcB6quuCyX4XfBDQYjbHTQEAqm0k2rnD/8Qo+A
	 S/hiOG+Oexi0GcQN/vf1lsuqcEprc8QoRgM7n/0gVv3y/Ok80FoOGkjnTsOOiumvTJIHy
	 E2c65HypPZHOSMf2UmSpt2OdQg7WAbfJk01JTPL23AKZHYIc7fckjCpfsEe/7NLMzkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089917;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Message-ID:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Feedback-ID;
	bh=C+vkxyU67zeMcKwQ1EK2nacMQDWtW7hAmQ/dpae/8Nc=;
	b=hGvdpI5vXC6sHAjILztfK03serElZhdO+Z2xkUJWFkqZBOtydIseDazyRCO8aSfLgLGy
	 r7NOZKMN134VR51g+PARigtIC4iOf883yLD0KYvBf1Z114sZ5+4Nl5nDtSwDNJeJ7NVxz
	 Oop7X4T9VEwuiaPTv+6C5OY4BtcQnji3voj4tFAe0BWH+Tp2zNrZ3U65Xak5cEbjJLMqR
	 3JlRSzLNwEuO4/5zKEgf3nH/eIxo4KE7YQ9u222I+lD6PcJUWGY55e2h2dX8W/SVw5Cfw
	 6FiCNKqZYvuLmjVwQQFQX3OVSItmyfPWeXFTbC35Y+Hqbdfp7l7oxf7tl7MRzu2SM0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tuta.io;
	spf=pass smtp.mailfrom=tuta.io;
	dkim=pass header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1 header.b=1fVdC8uS;
	arc=none smtp.remote-ip=185.205.69.214
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDE7606A326
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 08:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BDE7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1 header.b=1fVdC8uS
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id C2F3919D206ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 09:31:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793089915;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=C+vkxyU67zeMcKwQ1EK2nacMQDWtW7hAmQ/dpae/8Nc=;
	b=1fVdC8uSvxRplZYoxPCMM2VzmVJvp8Ayml4xvbBTROZ5YDWPWCcefGplVhfbuv8f
	LlOdbmrMZm1bGSP7DkNT8kOR8lfMIk0THHNbnnzVi+Tst254XO0tI3hiU8f2FUWfA4C
	3YXSdKws03ewH1Nrd3pQEDFo1WBMuIUmXaedOmjY9ydFXKtOua2uC2ZYCNiqkge97Ku
	SL5NQlLcXxUaNy2qz8B2WRy4r2OKlC4LyKDnvVcsNA+wPi4kvPE3qblW6VChlyA35+M
	VRvhXhNLIB7nsnroJ9teNnYPYgwafR1FE/g5R2UQ9XbaHbqsR0icBwEf4loWCRSabbK
	7lI3ZW233g==
Date: Tue, 27 Oct 2026 09:31:55 +0100 (CET)
From: Edvard Conrad <edvard@tuta.io>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Edvard Conrad <edvard@tuta.io>, Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Message-ID: <P4wUBaI--F-9@tuta.io>
Subject: Re: [PATCH] backing-file: inherit FMODE_NONOTIFY from the user file
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: 0127f977f5e13e8051b46c6e7f57d0f95a0470d24b79d7c31d07fdf611cc427ab823e0f4692a810119c92d8768973a9281:TurnOnPrivacy!:tutamail

On Tue, Oct 27, 2026 at 12:53 AM Amir Goldstein <amir73il@gmail.com> wrote:
> Any chance you can post this as an LTP test?

Yes. Written and verified, I will post it to the LTP list shortly as
syscalls/fanotify26. Two cases: a mark on the overlay only, which passes
on every kernel and keeps the test from passing for the wrong reason,
and a mark on the overlay plus the backing filesystem, which is the
shape that deadlocks.

> Urgh I hate how special case this is.
>
> How about something like below (untested)

Agreed on the shape, and it covers backing_tmpfile_open() as well, which
mine did not. As posted it does not fix the deadlock though:

> -       f->f_mode       = OPEN_FMODE(flags);
> +       f->f_mode       = OPEN_FMODE(flags) | fmode;

Five lines further down init_file() calls

	file_set_fsnotify_mode(f, FMODE_NONOTIFY_PERM);

and that helper clears FMODE_FSNOTIFY_MASK before it sets its argument,
so the inherited FMODE_NONOTIFY is dropped again. The backing file ends
up at FMODE_NONOTIFY_PERM, which is not FMODE_FSNOTIFY_NONE(), so
fsnotify_open_perm_and_set_mode() does not take its early return and
still raises FS_OPEN_PERM on the real path.

Measured in a VM on a defconfig + OVERLAY_FS + FANOTIFY +
FANOTIFY_ACCESS_PERMISSIONS build of this tree, with the reproducer from
the patch and with the LTP test:

  kernel                        reproducer    fanotify26
  mainline                      hangs         1 pass 1 fail
  v1 (fs/backing-file.c)        ok            2 pass
  your diff as posted           hangs         1 pass 1 fail
  v2                            ok            2 pass

v2 keeps your structure and routes the fsnotify part through
file_set_fsnotify_mode() instead:

	fmode_t fsnotify_mode = fmode & FMODE_FSNOTIFY_MASK;
	...
	f->f_mode	= OPEN_FMODE(flags) | fmode;
	file_set_fsnotify_mode(f, fsnotify_mode ? fsnotify_mode :
						  FMODE_NONOTIFY_PERM);

One deliberate difference from your version: it inherits only the "no
events at all" mode rather than masking FMODE_NONOTIFY out of whatever
the user file carries. A user file in the HSM mode (FMODE_NONOTIFY |
FMODE_NONOTIFY_PERM) would otherwise leave its backing file fully
silent, suppressing the events on real files that bc2473c90fca
deliberately enabled.

v2 follows in this thread.

Thanks,
Edvard
