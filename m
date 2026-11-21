Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795285024;
	b=K2quCWcjs/u7ejMr8ryRxs1ZN2tKTucyzxBhjBbKGAqwbhJZ3TU8r2mz7oCmWD+w1iId
	 824lQJ9ra9RULicqoHbKlVoTD7vhzK2DVQcbqynvHYTd8sqzbyA/YxQexHLLGIl4gfXFd
	 lHF+Gf7j2odrwb6Wibd0qShAsQqvFm05OaR0liGQticJDex02l3HG5bn3mynZ+FhHW73M
	 J8wY+0iFBgaXQ7PTOsybJJAMEAm/bchZ5TRz8cfdh18/Q7FTunlhPqZV2LO/sTPG+HJNd
	 oYa0Xk8XSAP3o66jxloAb72UeM/0pBzfUzXAiYOILcctY0W6NIgfLnQRUKBFTznjGVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795285024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Message-ID:Date:MIME-Version:User-Agent:To:Cc:Subject:
	 Content-Language:From;
	bh=dqNTSFzVcne/6G4+gFUKM9x7KeHiLn3on0r1SG/5gJc=;
	b=mGc41SHcSEJTUFckwh43ndTja7q1GkN7EOUgQn34PMmy1ib9abHHn4F05U1fTZkG/iBf
	 MvA1LAoPPpPVATSRpTPxjf+FaAmTTfIhh4YdFtGBOBM0SFQ5gPyvleJINRJv6R/eftTQU
	 FJVRK4yTgIV1Z9NvKN8QZoT29SPTfvwmvssG0+hoJ5nbxxzGqXVCoDSUTyNNee+7Cl7FN
	 QasoSsVSFJ8AAXPmnpDshv1quBY5A7nLMHcMA4cVr/ZMhIb68Y6Hf+YFwjCZ+uBiVmBri
	 5Ka46PZmidxLNBsj1s5s7RUdSK8Z7VfOlSNguMs4Kqcnjitx62f+9e7VkpzLeHZ/beg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uenzrMOk;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE7606A320
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 18:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73FE7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uenzrMOk
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so19167875e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 10:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795285023; x=1795889823; darn=vger.kernel.org;
        h=from:content-language:subject:cc:to:user-agent:mime-version:date
         :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dqNTSFzVcne/6G4+gFUKM9x7KeHiLn3on0r1SG/5gJc=;
        b=uenzrMOkZejhYM2rsTa9ehoVYPnSdfH/4LG86gyhMERepQbfZOaRLg+S6UZOr4vgLb
         McEp/+qcnLM2JTqC9qPxb7Y5VvNQdZUBAPfT/NEyHj0L+1X0Byyh7yD1/6GyY3XotCjS
         6q1MJ6A0zf3dx7PQKpzT5uBC5Q2tYqQ+JBwi8rd2tGZp9SWb426uHLZkLdAGGXBKSm+v
         NVuiBS0MNZtk7JCfWTPG++Sb5JxSGtsDV3xJAQi914pqaP8+sFtZSCQfpo9TvCzwJ+Zs
         AVHnlSNReCrFr+1a/hB7408U8Nqev3KbbI8ShXd+RaXAV7kW+Di6LKfdhu0XTc+gtLgK
         UvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795285023; x=1795889823;
        h=from:content-language:subject:cc:to:user-agent:mime-version:date
         :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dqNTSFzVcne/6G4+gFUKM9x7KeHiLn3on0r1SG/5gJc=;
        b=ETFdKRluMh7ux0zf5ADEZWsVRDJajBXVxSAoHVXU2CfGVMHIXQMNWeHh8wXXR1+zo2
         kvqMzWDLgYFYCcnbUGjVgXISIZpK7S+bPOCflIa0yxTC7J6AnQqyoHc2snIuw1rNDvN/
         n1Vgtk9cU7Nd6znmiL2dcxYryHKwS3whjN1h+gUghjEdiZvuAvcmXJRwpw6oBA5ioxBZ
         RFAsFVCbQf0UO2gmr/uHhJH8SmVzkl5HRLHC5wFrEHCAjcxXarfi6tzhZoLIN8pYGPPf
         8VV1D5PlLznzh3F/05v2yFC1F44RbejVr88PR0ei+nnzGO21b0L1RNDgvN13swbPvbwx
         fg/A==
X-Gm-Message-State: APuU4Z98B0sN547EfpiLbF/i6/28W7dP2wdAoRdDUofYHYGAfScC32d2
	uQFWX+I+eHGKIw8xcaXUUkNtU7XpU6LqG/YwwjkhrA5TkTkt7cxMwkMx
X-Gm-Gg: AZFdTZdJcNwZ7tDRc2RhFkz/aPDOC809ul1xAYeN3DVRAAN+RZbLhDA90jpNFJwe8PI
	72e0ycmtcAczZe8V3Ctx9YUTJlYg2XYcj+cDApRuQw+Y+tU68Rx8Gok2uhu/P5Qe9lQBkpVeVfY
	jsINfDOl5OkK9kKeRBBGH00qB4Jq3YZodCPz0gUGFAwr5wdPMgwmvE846SLkPsI9SSWTi8D9QXs
	QtZrju96ki/cB5icP2MsZKV1Q+gfwRnEaqGajtDm0jpK6Z6m5A7GywwIpNJgcoLD2oo5X0nJ/+e
	MK8x5MOIPL43UUgeDnL0cm733C4BsUfRx/zf6PgZkE9j2fxKkRQnsU4nolO8YqOOKm0GwQ7oAzL
	8kQZbN3cZqg+X6JurMtP+S4hR/DnlUAUUuN86wWbDnDMhfucO7bimWFdpRXiJEIarF2Xdd7GBL7
	5T+ai5XAd0mcjthufv9vy5xxKqghpSJirJCiyB0IahBABh1dlE/p0paI+FSN7zxkSnN0yklmpGD
	PxQ9nOM3ZFX0la329/3JtRISS9gJM1kT8QfZhArExQ1XIpZtb0P/L3Dd8mIiaK5UsftR6yz02Df
	idDiBuCF2mAF+WneMgxzu8g+HLHPJ4rKKb82UTNFHXsxkM+7+kxFMTy2HYMQ9sYjdW0P97wj9qs
	N/Xwrh81H3qXr17PtAx/bu+RDJIJ/pQqgJsYbEF4MYZlnGte3l2znmA8BPRSPW0YanLBoxYdTOH
	RuGLXNI3ri7ctxOjE4sQytZEJR9WXXfkwHsJB3vQHfqJ7YBh7Y/qxchPZsJQ==
X-Received: by 2002:a05:600c:4f10:b0:4bb:60bd:5398 with SMTP id 5b1f17b1804b1-4bb88804d35mr160856195e9.10.1795285022699;
        Sat, 21 Nov 2026 10:17:02 -0800 (PST)
Received: from ?IPV6:2a02:1812:1423:2e00:b41c:537d:f8c3:65e5? (2a02-1812-1423-2e00-b41c-537d-f8c3-65e5.ip6.access.telenet.be. [2a02:1812:1423:2e00:b41c:537d:f8c3:65e5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906640a2sm60891905e9.0.2026.11.21.10.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2026 10:17:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------KFj9PfnAfEXXTuW3ZRSug4w0"
Message-ID: <45bfa4d7-e9e2-45f2-9e12-a794defae64a@gmail.com>
Date: Sat, 21 Nov 2026 19:17:02 +0100
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
To: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org
Subject: hfsplus: mount loops forever on an HFS wrapper whose embedded volume
 points back at itself
Content-Language: en-US
From: Aymen T <atijari00@gmail.com>

This is a multi-part message in MIME format.
--------------KFj9PfnAfEXXTuW3ZRSug4w0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

hfsplus_read_wrapper() follows an HFS wrapper to the embedded HFS+
volume and re-reads the volume header there:

    case cpu_to_be16(HFSP_WRAP_MAGIC):
            if (!hfsplus_read_mdb(sbi->s_vhdr, &wd))
                    goto out_free_backup_vhdr;
            wd.ablk_size >>= HFSPLUS_SECTOR_SHIFT;
            part_start += (sector_t)wd.ablk_start +
                           (sector_t)wd.embed_start * wd.ablk_size;
            part_size = (sector_t)wd.embed_count * wd.ablk_size;
            goto reread;

hfsplus_read_mdb() only checks the embedded signature, two attribute
bits and that ablk_size is a non-zero multiple of 512. With
drAlBlSt = 0 and the embedded extent's start block = 0, part_start
doesn't move, the next read returns the same wrapper MDB, and the
mount spins on that sector for as long as the device answers. There
is no iteration limit and no fatal_signal_pending() check, so the
mount(2) caller can't be killed. The default: branch can loop the
same way: hfs_parse_new_pmap() adds pmPyPartStart without checking
it, so an Apple_HFS entry with pmPyPartStart = 0 sends it back to
reread at the same place. I only reproduced the wrapper case.

On mainline (65e4fd942f72, 7.4.0-rc3) in QEMU, with the image attached
as a USB mass-storage device (qemu-xhci + usb-storage) and mounted with
flags 0x18e (NOSUID|NODEV|NOEXEC|DIRSYNC|NOSYMFOLLOW): mount never
returned, and the device saw 62,680 READs of sector 2 before the
120 s run was killed. The same image with
ablk_start = 8, embed_start = 1 fails the mount with -EINVAL after 5
reads.

Fix: refuse a wrapper whose computed part_start doesn't advance (or
limit the number of wrapper/partition hops to a small number), and
return -EINVAL.

Attached: mkhfs.py (python3 mkhfs.py wrap_loop loop.img makes the
image; wrap_once makes the control, which needs mkfs.hfsplus).

Thanks,
Aymen
--------------KFj9PfnAfEXXTuW3ZRSug4w0
Content-Type: text/x-python; charset=UTF-8; name="mkhfs.py"
Content-Disposition: attachment; filename="mkhfs.py"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uMwoiIiJIRlMrIHdyYXBwZXIgaW1hZ2VzIChmcy9oZnNw
bHVzL3dyYXBwZXIuYyByZWFkX3dyYXBwZXIgKyByZWFkX21kYikuCgp3cmFwX2xvb3AgOiBz
ZWN0b3IgMiBjYXJyaWVzIGFuIEhGUyB3cmFwcGVyIE1EQiAoc2lnbmF0dXJlICdCRCcpIHdo
b3NlIGVtYmVkZGVkLXZvbHVtZSBleHRlbnQgc2F5cwogICAgICAgICAgICBhYmxrX3N0YXJ0
ID0gMCwgZW1iZWRfc3RhcnQgPSAwLCBzbyBoZnNwbHVzX3JlYWRfd3JhcHBlciByZWNvbXB1
dGVzIHBhcnRfc3RhcnQgdG8gdGhlIHNhbWUKICAgICAgICAgICAgdmFsdWUgYW5kIGp1bXBz
IGJhY2sgdG8gYHJlcmVhZGAgd2l0aCBpZGVudGljYWwgaW5wdXQuCndyYXBfb25jZSA6IHNh
bWUgTURCIGJ1dCBhYmxrX3N0YXJ0ID0gOCBhbmQgZW1iZWRfc3RhcnQgPSAxIHdpdGggYWJs
a19zaXplIDUxMiwgc28gcGFydF9zdGFydCBhZHZhbmNlcyB0bwogICAgICAgICAgICBzZWN0
b3IgOSwgd2hlcmUgYSByZWFsIEhGUysgdm9sdW1lIGhlYWRlciAobWFkZSBieSBta2ZzLmhm
c3BsdXMpIHNpdHMuIENvbnRyb2w6IG9uZSByZS1yZWFkLCB0aGVuCiAgICAgICAgICAgIHRo
ZSB2b2x1bWUgbW91bnRzLgoiIiIKaW1wb3J0IG9zLCBzdHJ1Y3QsIHN1YnByb2Nlc3MsIHN5
cwoKU0VDID0gNTEyCgpkZWYgbWRiKGFibGtfc2l6ZSwgYWJsa19zdGFydCwgZW1iZWRfc3Rh
cnQsIGVtYmVkX2NvdW50KToKICAgIGIgPSBieXRlYXJyYXkoU0VDKQogICAgc3RydWN0LnBh
Y2tfaW50bygnPkgnLCBiLCAweDAwLCAweDQyNDQpICAgICAgICAgICAgICAgICAgICAgICMg
SEZTUF9XUkFQX01BR0lDCiAgICBzdHJ1Y3QucGFja19pbnRvKCc+SCcsIGIsIDB4MEEsIDB4
ODAwMCB8IDB4MDIwMCkgICAgICAgICAgICAgIyBTTE9DSyB8IFNQQVJFRAogICAgc3RydWN0
LnBhY2tfaW50bygnPkknLCBiLCAweDE0LCBhYmxrX3NpemUpICAgICAgICAgICAgICAgICAg
ICMgZHJBbEJsa1NpegogICAgc3RydWN0LnBhY2tfaW50bygnPkgnLCBiLCAweDFDLCBhYmxr
X3N0YXJ0KSAgICAgICAgICAgICAgICAgICMgZHJBbEJsU3QKICAgIHN0cnVjdC5wYWNrX2lu
dG8oJz5IJywgYiwgMHg3QywgMHg0ODJCKSAgICAgICAgICAgICAgICAgICAgICAjIGVtYmVk
ZGVkIHNpZ25hdHVyZSBIKwogICAgc3RydWN0LnBhY2tfaW50bygnPkhIJywgYiwgMHg3RSwg
ZW1iZWRfc3RhcnQsIGVtYmVkX2NvdW50KSAgICMgZW1iZWRkZWQgZXh0ZW50CiAgICByZXR1
cm4gYgoKZGVmIG1haW4oKToKICAgIGtpbmQsIG91dCA9IHN5cy5hcmd2WzFdLCBzeXMuYXJn
dlsyXQogICAgaWYgb3MucGF0aC5leGlzdHMob3V0KToKICAgICAgICBvcy51bmxpbmsob3V0
KQogICAgb3BlbihvdXQsICd3YicpLnRydW5jYXRlKDY0IDw8IDIwKQogICAgaWYga2luZCA9
PSAnd3JhcF9zdGVwJzoKICAgICAgICAjIFNhbWUgTURCLCBidXQgdGhlIGV4dGVudCBhZHZh
bmNlcyBwYXJ0X3N0YXJ0IGJ5IDkgc2VjdG9ycyBlYWNoIHRpbWUsIHNvIGVhY2ggcmUtcmVh
ZCBsb29rcyBhdCBhIG5ldwogICAgICAgICMgc2VjdG9yOyBub3RoaW5nIHRoZXJlIGlzIGEg
d3JhcHBlciwgc28gdGhlIGxvb3AgZW5kcyBhZnRlciBvbmUgZXh0cmEgcmVhZC4gQ29udHJv
bCBmb3Igd3JhcF9sb29wLgogICAgICAgIHdpdGggb3BlbihvdXQsICdyK2InKSBhcyBmOgog
ICAgICAgICAgICBmLnNlZWsoMiAqIFNFQykKICAgICAgICAgICAgZi53cml0ZShtZGIoNTEy
LCA4LCAxLCAxMDI0KSkKICAgICAgICBwcmludCgnd3JhcF9zdGVwOiBNREIgYXQgc2VjdG9y
IDIgLT4gcGFydF9zdGFydCBhZHZhbmNlcyB0byA5IGVhY2ggcGFzcycpCiAgICBlbGlmIGtp
bmQgPT0gJ3dyYXBfb25jZSc6CiAgICAgICAgIyBhIHJlYWwgSEZTKyB2b2x1bWUgc3RhcnRp
bmcgYXQgc2VjdG9yIDk6IGJ1aWxkIG9uZSwgdGhlbiBzaGlmdCBpdCBieSA5IHNlY3RvcnMK
ICAgICAgICB0bXAgPSBvdXQgKyAnLmlubmVyJwogICAgICAgIG9wZW4odG1wLCAnd2InKS50
cnVuY2F0ZSgzMiA8PCAyMCkKICAgICAgICBzdWJwcm9jZXNzLmNoZWNrX2NhbGwoWydta2Zz
Lmhmc3BsdXMnLCAnLXYnLCAnVCcsIHRtcF0sIHN0ZG91dD1zdWJwcm9jZXNzLkRFVk5VTEwp
CiAgICAgICAgaW5uZXIgPSBvcGVuKHRtcCwgJ3JiJykucmVhZCgpCiAgICAgICAgb3MudW5s
aW5rKHRtcCkKICAgICAgICB3aXRoIG9wZW4ob3V0LCAncitiJykgYXMgZjoKICAgICAgICAg
ICAgZi5zZWVrKDkgKiBTRUMpCiAgICAgICAgICAgIGYud3JpdGUoaW5uZXIpCiAgICAgICAg
ICAgIGYuc2VlaygyICogU0VDKQogICAgICAgICAgICBmLndyaXRlKG1kYig1MTIsIDgsIDEs
ICgzMiA8PCAyMCkgLy8gU0VDKSkKICAgICAgICBwcmludCgnd3JhcF9vbmNlOiBNREIgYXQg
c2VjdG9yIDIgLT4gcGFydF9zdGFydCAwKzgrMSoxID0gOSwgSEZTKyB2b2x1bWUgaGVhZGVy
IGF0IHNlY3RvciA5KzInKQogICAgZWxzZToKICAgICAgICB3aXRoIG9wZW4ob3V0LCAnciti
JykgYXMgZjoKICAgICAgICAgICAgZi5zZWVrKDIgKiBTRUMpCiAgICAgICAgICAgIGYud3Jp
dGUobWRiKDUxMiwgMCwgMCwgMTAyNCkpCiAgICAgICAgcHJpbnQoJ3dyYXBfbG9vcDogTURC
IGF0IHNlY3RvciAyLCBhYmxrX3N0YXJ0PTAgZW1iZWRfc3RhcnQ9MCAtPiBwYXJ0X3N0YXJ0
IHVuY2hhbmdlZCcpCgppZiBfX25hbWVfXyA9PSAnX19tYWluX18nOgogICAgbWFpbigpCg==


--------------KFj9PfnAfEXXTuW3ZRSug4w0--
