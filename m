Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658266;
	b=eY01NBMN9cls7KNdmwBBhQ/rVPIUmDzokCTkCq+0HHJTmd82/VS8wwRcOWfkfRBuQ4yQ
	 F4drJ+RQ9R5ns41O7TfwfNN71iQ+dUGqo40pi+sA5nfZFfOm/OVBxqQbKoBJ+o3fzgXSt
	 fOvWF/V7Jhzw16ORYVGDpDW57TjKIDcYduj14w8xwjN2d0qrOaLadFDoURCh25BbobmGv
	 rqYyDYQizP0i6R8lLIj+GVx37NkY4KKVZF+gsahewkN5oB/0FfcNl8tQzgB2dWFKdOlvX
	 nnqQjyd1GaAJ23faVemb+qFXP1pdCpy/P76/MBlVMUzGWofRX+VKsw2pCjbw5KryCAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=UovCA83FNsPuBSnfAJd4uLUjnukL3oT2mIC2wyc1NfU=;
	b=Q+YNA9LxivD63BkW64riRhkrdka5JKKioud9Qw+W0fY5alQqN7fbhca5abD7A40yKGSB
	 /nZN/w2B4kwvUoDaguhRGQTrE7jJob/gCfEtzSvVNDznFxJZKPYmEw7j9VT2VPqEiajAL
	 ydSD/+NLJm2p92ded+Xmjc96s7M5qjNc6SsNYQKxO7t0+g+YEt3gYv/ekJL9g9qXTH3F6
	 NEisWUShTFnsWkpY/BGB9nM37EAF134oYI2jp7KeFZqPkgajYOZGTTdxvrr4Gv91Keeem
	 RgV2o3MjIiOUDgHq+8vlFbsBEt8WDLyTT7Ox48JlUs3Ivsz9M9YmAAStYxIVVF1gGEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Q3+J7aud;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519A606A326
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 22:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C519A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Q3+J7aud
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0d91601bdso894837b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 14:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1793658265; x=1794263065; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UovCA83FNsPuBSnfAJd4uLUjnukL3oT2mIC2wyc1NfU=;
        b=Q3+J7audqHGERTCoLWp73gLhy/VhNKpid7iSdpb1t2D1mF9aigw4KjOj4TaPv+hgeB
         1ubVS6ejmoV103JciLCg5KksBaF510SmLhkxcepRbJHz9gv7sAvwEL+LC2O+6ggCKyTo
         uPYh7gu9bAoTdIAfpCazhuZcWb+XDQN79gA9cxDDqP0dBhtw5fc5ADlbpdkkpoo2ahoj
         1W6/JugBLkzvQ9MsVTFvLlBtFta28rwdjOlpAlxrmafqTKvlUX9EvrYE4kmSvW2GzFLL
         GaCDPzOUqtGuYBBML/v2kJD5KWpLF0sea2cccxvLYH1BeiupWraZlK2nhx1jE6akh5Hy
         ipug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793658265; x=1794263065;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UovCA83FNsPuBSnfAJd4uLUjnukL3oT2mIC2wyc1NfU=;
        b=uXT/L964rlRSx/38VWpEOOxpryzWVC4ZfL4dF31oLewnpi7DCoHc1Chh4EgCHMrV0s
         ccpIrvsBNsisadWz7hRl3YuKqPUsGWXHn6Ns5sE3+6mMuxV8rt8yI4NbQ/+HOlqPPznS
         v7LiZkM4aZmvXLMuV9GiyZ/AymbPpInm9eN+uQIfbcVGR/Q/XGX+xnyqD0Lj0+K21rdZ
         IfMgKBBdxc+wN/KEm01rKh83f7DgXu0Tcw1e1CqWnuLD5j/VIN+HlbgTthZJXpWF37dr
         Ekg1znlWD6xaG5nZUA0RczOS7L9TTRGEhapy8PSyYsgLydjKMA/lSinHASLX/4hKoerM
         flJA==
X-Forwarded-Encrypted: i=1; AKwUvByBVt5m+Jm8KUJYkSpPmc+EODpCJSt3Xb2XfcMlThI6HGCXAR5gYrWO6/+OdkDY4LKv2MPxFrs1k0Jz4c6x@vger.kernel.org
X-Gm-Message-State: APuU4Z9kZuMkvVlls2k0E5w3kH1R7AO37drDeVa0tCbBnLMW9oB9Uh0M
	WEQArTGW3biAlXuFh0nh4WiyrmE91dMvJnyEoGSJJ7PW0t5UuBiXw2fUUzC9kXrjfSc=
X-Gm-Gg: AYBFou3tycMTzD3O7T1Wb4ZaBamXbKTsQa8GZZOHfHzHw995jBfbZ6fXjgqqHPBHs4X
	84Q9ez3PMgW5M8eP3E2CPpNnUu8tE0HUcZ3YB+5sNXVT/rxagab4eekjk3BliU4+8gqxIL87HLI
	p0ldiEClt479XCwqcE3p/eZxahqDsRB80Ypsivjo3nZ2bFnNRPBdcpVdkWrwd4ojEoC3MZVgjQn
	bjSeELhtRpY/wdswNMG71lPCUTtdoA6L0BLR4X/kxFFgFCgfsWdvu6UQhuuiEoX1dJmacDrJTUA
	UkMU3ZI1aLfKQF6W9ZaNnr7ucC3C0PxCUWRVCGzZAGbxDlZi7xatXUXhMArzZXJlfViLG7PElXu
	ENzdVjKgXc1sJqay5AGVrTUn770Z9vfwDUcZey4qN2BGzMOP0W3BlztQyTyYJ8jlBH6VCoqoCow
	Fcx1C3U1H0uLO5q9vXiscHZDinITkfI4pPPS/FwiP3BrNo3aXJts/OyQrDuV/YbdxC7Yz78F9Or
	CUaWrTCkyGjVRf72G3ipBiDP5tDN+LezuOFwDycNH96M0lpXc7Y4rICs7vaowH1khmEvSKGjaYv
	uAfcPj4aP4eJbUpiIRVK5M//lE+EvOd3PxjB/ceVC81+JUSAcBHmge3zSmD65K6dfgxeYSYlCzV
	kEOrZ+sRjI3Ikg77ccoq06TPtQHuhUHrNHOO+53zDnK4SNP1Sg8qZfJHWxs+Lb1P1K20IdolF01
	r5FxteJ1j/SmWsWUQS
X-Received: by 2002:a05:690c:113:b0:8b1:567c:e7d3 with SMTP id 00721157ae682-8b2b66cc93amr82163457b3.7.1793658264800;
        Mon, 02 Nov 2026 14:24:24 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:2f9f:a96f:bcb:6021? ([2600:1700:6476:1430:2f9f:a96f:bcb:6021])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b714bdafsm60869707b3.19.2026.11.02.14.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:24:24 -0800 (PST)
Message-ID: <bf9e6dd5ba33b10187d6db47b0a361e34a0d04d6.camel@dubeyko.com>
Subject: Re: [PATCH 0/2] hfs: fall back to buffered I/O for direct writes
 past phys_size
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 14:24:23 -0800
In-Reply-To: <20261030042903.4160506-1-hengyul@cs.unc.edu>
References: <20261030042903.4160506-1-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-10-30 at 00:29 -0400, Hengyu Liang wrote:
> Hi Slava,
>=20
> As discussed in the setattr thread [1], a direct write that ends past
> phys_size loses data at the last close, because hfs_file_truncate()
> zeroes the file from phys_size up to i_size. Patch 1 makes such
> writes
> fall back to buffered I/O, as FAT does. Patch 2 is the
> hfs_file_truncate() cleanup you suggested.
>=20
> The series applies on top of "hfs: report errors when extending files
> with setattr" v2 [2], which patch 2 needs. The HFS+ fix is sent
> separately.
>=20
> Tested in KVM with KASAN, all 805 fstests on HFS with that v2
> applied:
> 26 failures without the series, 14 with patch 1 and 15 with both, no
> new failures. The extra one, generic/589, fails on and off on all
> three
> kernels with "invalid MDB drNxtCNID", the next CNID issue from the
> CNID
> thread.
>=20
> [1]
> https://lore.kernel.org/linux-fsdevel/161fab786f919adb384fbf22dc19f3289bf=
5f24d.camel@dubeyko.com/
> [2]
> https://lore.kernel.org/linux-fsdevel/20261021145627.288953-1-hengyul@cs.=
unc.edu/
>=20
> Hengyu Liang (2):
> =C2=A0 hfs: fall back to buffered I/O for direct writes past phys_size
> =C2=A0 hfs: remove the dead grow path from hfs_file_truncate()
>=20
> =C2=A0fs/hfs/extent.c | 18 ++----------------
> =C2=A0fs/hfs/inode.c=C2=A0 | 10 ++++++++++
> =C2=A02 files changed, 12 insertions(+), 16 deletions(-)
>=20
>=20
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
> prerequisite-patch-id: 737ea6125c4a7fa08a4deb38cf33d27fb791a812

The main plan is to rework as HFS+ as HFS code to remove the
hfsplus_direct_IO(), hfs_direct_IO(). I am already working in HFS+ code
[1]. If you like I can suggest to you to do the same on HFS side. But,
unfortunately, this modification will be completely wiped out in the
future. Would you like to take the task of reworking HFS code by
removing hfs_direct_IO()? You can follow by HFS+ pattern (if it works).

Thanks,
Slava.

[1]
https://lore.kernel.org/linux-fsdevel/20260914233941.2966421-1-slava@dubeyk=
o.com/

