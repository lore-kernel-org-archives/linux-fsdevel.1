Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BCF331207
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791771047; cv=none; b=AH4IYwUYTvHGtzoHzO/WHAjt1g2LV5dfkr9ysOoGkHAU2SfwtWjop8LkWxX5vYVMdd26PPXZJASv4TGnvd8zhLEy575fx+jhArWin6Q+JO3Bt+uNLz5bV47D4icOmzHajTSDMwJqBSONh+C0fI5iB0MEfKPxBe+L+xxGeT8yST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791771047; c=relaxed/simple;
	bh=FRfsH2a4E3p5CuJK+bm+CkI5NiJqU/Rf6ZDUXTFlxmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+d0npR8TEnGyM2zw0Ly+lcApMbJGFMUuvPVGtP44YMf/A47HGkZyT9bbyGXLQM84MUnulbxQRNnxo9KbVf5clMQIrN5pYa7LoJ43C7EuNZ+K34v0JPIcpeXPSj9R/w99ExldY+sXEgdYMieAtlUVTzCEQxyN2EG1uqyktclt6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=ZtoKLAvY; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="ZtoKLAvY"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-930c0f9c1b1so133408585a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 19:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1791771045; x=1792375845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4VDPRHlAVT+FhshM7ZE+VmlyVvQPAjXCn2Is7q88QJY=;
        b=ZtoKLAvYPssRJrUd+BhTPxhzl5O42F/UTI8aRBiNLK30g7Ep7u4FpsM+RNixLpDPVs
         DC8+kG0lhkJn2/kNj1l+3DEwAcDrOIgws1AmXzSnrU3epAlxiUcksN7po9w9WC//v6tb
         RQPueV11malMmF5WQpIel0noUkXH2Fe6oMev9J9VRLnUsRCiNj+TGAWlStLQYkIHFdZc
         PTCAVUbXNXt1Q07vWNXt2ZYl0zsfIwOZH8mBCHiIrtfM3DjuTdTlBTE26m/a5kT6uRFU
         sZRiYgd3FGbNxoRuLeM6TlVFvVD6OoalBbBM60EDDhhvOZaRay4sybdZwZ4/8FvjHNb+
         FxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791771045; x=1792375845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4VDPRHlAVT+FhshM7ZE+VmlyVvQPAjXCn2Is7q88QJY=;
        b=fdKW1BOmokLfdQKSbWzHMMRV9dOxck5gkTsT1nd5ipo1hKw2rFB0IVd6Q1Vo32LvNO
         AatS09Z2VoEWErjWpAOJ841/+37LmwIZ3dOjZVi7JgKxlZnIGGB3mlZDtB55Wjm9BMTD
         d7VP4AwfecvGO/qja4f/lZ/Tm1DVBnnUWB616RxYMN0W8fr8OzCID2IWSwd3ASc7KUeJ
         Myy5mUFLxa5RQCKvMxCgAtbEprVAl8Q4Y8jL71y2cE436IUywvl0zlFLXMOxDy4xsHXl
         oOHeABR0Mq5R2KxxOXS5dKlwTw5ivyHlZlszUg1W/yfqTexVx4hRlFQFgCRHmksThFkR
         Z2aA==
X-Forwarded-Encrypted: i=1; AKwUvBwYTqUTK+cpO1LHpSOcdRiQ74635D2nP3mLomXSueQwoWvBodhjaNXhHCM7uq5pS5zivbctt8mmVlTwTuJA@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1p2JsIRX8hy4ORplof4hRwnsFtNAU+fvjYhEEpYVZKADhYBDU
	hnMpyAGYGOcNq2elQC5SB4gjhpRAzlBLvT6dFcO6hx0RXEmqtyejo+ze+uaD4gVUIg==
X-Gm-Gg: AYBFou1uq9SU7D0JYf3S6QBJu1Gv37UsvI29utKqNgPKkmEHFGUNN+JlhMwYbYETlZ2
	Ar0gEhi5hViFkcoisGGUDarQrTEIQxNRRIIWCrPNctfo0b3Ov7upSb9jOGUEr1aStsoNqhmcp1s
	nL1ZQR/p/9ZPDKygN0bEBYlC3cVpW9SsEuSiL+jiyoGqH7i0LqkqhVeRv9kP1LIaZlsIPnxGGle
	GJzIlAAvFVhYtkDVr2I6rxK7ZioU9hN1RDc0CsRqHW+gCImzU09K0fdud65ldOSRi75QiS9jIyt
	HWbEi25yRcNQtcolMP3uL2KheZ1nf1tNV8bGSa9uM2bv8xdrVp/9WJ+XcVCt3EV9FrXsvusZB7g
	YAKtOTfkux246yIHc2AfIZPGKaaVhISxlrSSSdKSdyFXtdfCPE4uJsFHUOnrEMcbgR70EZUI838
	i62L92QHxibEOGwf3UbkjEHKrEsDfpkZiHevNphvqkd50nhA+B5qVARcl0uNuACBz4USTLdlody
	uzCkjIvgQmpw0HredpnFw==
X-Received: by 2002:a05:620a:2549:b0:93c:6e1d:96af with SMTP id af79cd13be357-93ebd24a07cmr1372253985a.49.1791771044657;
        Sun, 11 Oct 2026 19:10:44 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb986c350sm754861285a.22.2026.10.11.19.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 19:10:44 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Thomas Schmitt <scdbackup@gmx.net>
Cc: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Matthias Goergens <matthias.goergens@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: Fix handling of directories with small logical blocks
Date: Sun, 11 Oct 2026 22:10:04 -0400
Message-ID: <20261012021004.2105580-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <13464510581423749223@scdbackup.webframe.org>
References: <13464510581423749223@scdbackup.webframe.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas,

On Sun, Oct 11, 2026 at 10:29:07PM +0200, Thomas Schmitt wrote:
> Do i get it right that lbs1024.iso contains in the Primary Volume
> Descriptor at BP 129 to 132 "Logical Block Size" the value 1024
> instead of 2048 ?
> (Where could i get such an ISO image ? And how was it created ?)

Yes, BP 129 to 132 hold 1024.

I do not have such an image from a real medium, and I do not know a
program that writes one. I made it by hand with the script below
("python3 mkiso.py lbs1024.iso 1024"). It is minimal: a Primary Volume
Descriptor with only a few fields set, the terminator, and one sector
with a root directory of 40 empty files. To keep it short the script
writes no path tables. The kernel does not read them, but other
programs may reject the image for that.

    # mkiso.py <image> <logical block size>: ISO 9660 image, 40 empty files
    import struct, sys
    lbs = int(sys.argv[2])
    root = 18 * 2048 // lbs
    def b16(v): return struct.pack('<H', v) + struct.pack('>H', v)
    def b32(v): return struct.pack('<I', v) + struct.pack('>I', v)
    def pad(b): return b.ljust(2048, b'\0')
    def rec(name, block, size, flags):
        r = (bytes([0, 0]) + b32(block) + b32(size) + bytes(7) +
             bytes([flags, 0, 0]) + b16(1) + bytes([len(name)]) + name)
        r += bytes(len(r) % 2)
        return bytes([len(r)]) + r[1:]
    d = rec(b'\0', root, 2048, 2) + rec(b'\1', root, 2048, 2)
    for i in range(1, 41):
        d += rec(b'FILE%04d.TXT;1' % i, 0, 0, 0)
    pvd = bytearray(2048)
    pvd[0:7] = b'\1CD001\1'
    pvd[80:88] = b32(root + 2048 // lbs)
    pvd[120:132] = b16(1) + b16(1) + b16(lbs)
    pvd[156:190] = d[:34]
    img = bytes(16 * 2048) + pvd + pad(b'\xffCD001\1') + pad(d)
    open(sys.argv[1], 'wb').write(img)

> The mount option block={512|1024|2048} may set the address unit for
> reading the volume descriptors in isofs_fill_super():
>          opt->blocksize = sb_min_blocksize(s, opt->blocksize);
> This means that if it gets through, it is the assumed Logical Sector
> size.

As far as I can see, the option sets the size of the buffer that is
read, but not the place. The loop over the volume descriptors has

	block = iso_blknum << (ISOFS_BLOCK_BITS - s->s_blocksize_bits);

so sector N is read at byte N * 2048 for every value of the option.
The sector size is 2048 there as well.

> So if the user is allowed to set an initial Sector size, shouldn't this
> be used for the check in this patch, too ?

I think 2048 is the right value for the check. By ECMA-119 6.1.2 a
Logical Sector has 2048 bytes or more, and isofs_fill_super() fails
when the block size of the device is larger than 2048. So the Logical
Sector has 2048 bytes on every volume that isofs mounts.

If the check used the option, its default of 1024 would make the check
reject every record that crosses a 1024-byte block, which is what
happens now.

> So can mount option block={512|1024|2048} still have an effect at all ?

I see one effect. The mount fails when the logical block size of the
volume is smaller than the option:

	if (orig_zonesize < opt->blocksize)
		goto out_bad_size;

I tried images of the three sizes from the script with every value of
the option, on a loop device, on v7.2, on v7.3-rc6 and with the patch:

    lbs512.iso    mounts only with block=512
    lbs1024.iso   mounts without the option, with block=512 and with
                  block=1024, but not with block=2048
    lbs2048.iso   mounts with every value

A failed mount logs, for example:

    ISOFS: Logical zone size(512) < hardware blocksize(1024)

When the mount succeeds, the result of "ls /mnt | wc -l" does not
depend on the option. It is 40 on v7.2 and with the patch. On v7.3-rc6
it is 9, 19 and 40 for the three images.

Thanks,
Hengyu
