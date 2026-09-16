Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B1494835
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594690; cv=pass; b=gzp6HdbDUQftWQxhGRPleoG0eBI3fmvQodDr/0l170rzenMezCd3fG7dVY2dP+Zx1j3di6Q0wlAnhTuHEDnIZd0btJwowCvlPAU6IYeMqW4A0mI0qjCW2ZSV1tOWho5SUf7Svls7TrXtErnvlOXz2g3R12AbXlUcoM6kFqMChLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594690; c=relaxed/simple;
	bh=/yoayJNWHYIrjv0q4LQ1nltisZwWSxYj+42fLHl+PiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNYx7H0BrsnpLjlQ6wDVAN9IyaDKRFyL+ufowZBV5IkEQzVxCVIGGorrUYT8rrvbc5qD1FrjJAGkyzaG7JJmEPl6J1BX/fiQjysoV7wDc6iFx+nrIYjOXpwW9OMwncVMEaNKzZb7tcf9DPPRBx1nbSSPM4NNawJbgwUBKvSAxqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thechris.in; spf=pass smtp.mailfrom=thechris.in; dkim=pass (2048-bit key) header.d=thechris.in header.i=@thechris.in header.b=q83rPIWU; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thechris.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thechris.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thechris.in header.i=@thechris.in header.b="q83rPIWU"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43db0c17so891507b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 14:37:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789594675; cv=none;
        d=google.com; s=arc-20260327;
        b=CtD5YyorAziVTLiU1nXN1MlpDzMp4v1YcXwUqH7jSznWDHAknhx3J2UPUwumFx1n5M
         Z/2Z54N9CfjJgLmm4xTXLcBMlS8sO3qT8XAL/1tpvGxq8l3/dFvYYpFTwQxjJNYpJfb8
         vG7dj1YRUWopCnUHy+KH+XfUQ2A9WRiDeIMKEYuWNEFwbgHcuh9HXBj6muEZw5Il4Goz
         bztGaKKiEjmKDJfa62G/pto9l7ww1JfSV6ZJpeDNqNwRzCOigoPv294XqWv2favs44O2
         xB5mgtZ6jcNyQq9jBwcvZBhDuWKAjfX40NRUpbCK93g8tz72Sd93OWV9R20VlDEBZMY4
         LSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sA5xGrr7Ke9vPI+EDSrVqhlx5pMIJsn3eZ9roOIuI3M=;
        fh=cKXJBrX4rWl5qvfRifVWDF+qYkovnjzbjWoLOE7vL3g=;
        b=U7VU9dM7eHuXSz1/FDbMt/brCO3wQKKRqDqr0mh1/Lz4bifBzk/CCgjDsAk1XnhS0d
         a33O6lFm3MS+trK8Jn+sOGeoJcQS3/SUbZw8wzOER0L1gAJvMqLa24eQftdTv05u6sRw
         yZTe+eJBwU9yV3xCLEbEJtBYNLPJ2y7FZs27oVs6ZGf6Veaytw6JpOAxyTRzlHwwyVU0
         KQnuzbkgGooGLtsqeXNkeFUpP2b9TYCP9lmtH1eSRl3uO1QQawsDwz/SB8uRXnWzWfGX
         ynlrD3JsvYZqQ84C/+mTlHLAS3Yjab8ONiGyRHXUJlZ6XIWIgFH6OuokQd8X57nZ55Ir
         rKTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thechris.in; s=google; t=1789594675; x=1790199475; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sA5xGrr7Ke9vPI+EDSrVqhlx5pMIJsn3eZ9roOIuI3M=;
        b=q83rPIWUQO2m5w6Yk3dFLArGs7MfhcCTn+66hsx9uK8E1R3abCn5tuiy1ZKDszF07k
         PFTZ/1XRu04Pvvy4FEPS3M1M9C9fuhOAS5xFc0l2XrD4OJOOGoU64ckDaheBth6UZycg
         /5ajaxamlBezxfkhTm3zP2e8hMNXMH+N91npsYN0lPdytrKlbVTp75v3rY+aDiJc4NG2
         s/1PpzLloOy9FJbfW1EwCc5DbmqtU+5h/e0YLZSbnEo1WPFCG+rjSizX0RD+qTdCVYdJ
         +6ozYHlqfJudLpUcjRmVwcmLlQgIMR75PyOHuri28yPcIG1Y3LEKhD9Ov6Gy/1ThMpB3
         AYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594675; x=1790199475;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sA5xGrr7Ke9vPI+EDSrVqhlx5pMIJsn3eZ9roOIuI3M=;
        b=CFlPpcjZJlQsRTjkpaelrhyp8mclhgYRl+gb/odpAAaTBKQXCxBERBPn5T/cHsxhAg
         2os1NSgizTG4vhR4W6JN+1gsZEutr7JdmLBj9fOsS7cakHqREeMgEvrGzypyOE2Ov5cX
         iZAdLzadmn7kKYaTPDcw8UUBB+9rgzY8N826+6yE2iu1BuotKtmyjZAtlIkfK8qTRATu
         ARbKqhUZTCLMVKX3oDp38tguNsw0AZBE1FhWkbs9y0uQNCicE29hhE+bZ/zfVlhRgB+w
         GDE/O0/FZtsLTKsldWVM/uwBfQYqic1Mbz86LD5EvrR/TNgxN1mM/PR8RkpT7Hr8NpUK
         Kvtg==
X-Forwarded-Encrypted: i=1; AKwUvBw714ckwO1YQlou4wBHeCGXYlVUyzEZ7pf4MwN8S1Z+fuZedI/vaJhhob2qeFIhG/ARVwTqDGfFQyVUFqPA@vger.kernel.org
X-Gm-Message-State: AFuF++khg9IHlHGu5KWYJ8x1uPoRXqY4sQSsrhoO+2qvQGVUPaOEgSKU
	QGuUle2GX/s4PYD1wp0CFoOVsOehpzNR8XW+4ZX5zJt2o1oJWvjGxWYwDpaT0s3Ib5Kx+JduDZs
	ObSW89ehgLTPIRCyrNRjRwBfY6J8GCgS4ZBlCYZP4MYg=
X-Gm-Gg: AYBFou2oTQUGneSDljbCguzjFfyC6pOvsHsewUoHwsQuDSgY7u3tgyUzB6BLLfe6hzC
	GwNXacuwWlDxCi3zwaU+J7JxDq97m/J8nkgYw21ncSxsz3Aw1dKdvfGNyH7z80hEFIr7sY946VG
	2nCwv1GsEWMr3385rtfDvmJhV1yv8KkdxB9QxjT0+at26j6UNdl6HSBrH1vk1buxJDhTSpzWJi4
	mNEN7tSZ7FwsMtp4bag6A6dIeLmSdk0pe9flVcS/IKIPuTcboy32hzp6GTd+GT6y+NSyg6CSk4x
	Q+z9x1P6bOc2IpxVVh1d/3oTEbqBdpep9Ncwn/kZ0PgwAAKCinyyqwHDgJHHLrJKzhHSD4TUIom
	swxSJSOtiZXzL2cL2HExhw9YYyHErBKIRFcjCm9jp9Fris1HmP21b4Z5/SxHcTCZzgXHxVuKV2U
	1mC3KWLV8Og1qOi00=
X-Received: by 2002:a05:690c:a713:b0:85b:f1ba:4cdc with SMTP id
 00721157ae682-892239084dbmr13385057b3.12.1789594674751; Wed, 16 Sep 2026
 14:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6aa178fc.f2639fcc.29487d.0008.GAE@google.com> <CAE2Bdm1nss=2F4rAFo8_AjZJ6XwBiVnCmfvaZmjBd7=ZYvouKQ@mail.gmail.com>
In-Reply-To: <CAE2Bdm1nss=2F4rAFo8_AjZJ6XwBiVnCmfvaZmjBd7=ZYvouKQ@mail.gmail.com>
From: Chris Roy <iam@thechris.in>
Date: Thu, 17 Sep 2026 03:07:43 +0530
X-Gm-Features: AcwNN1Xj30vxoYQjY2kqZ399kjYntXWVBFuL78FVIXAxOwR1_HpftSqML7BMPGM
Message-ID: <CAE2Bdm3NuEHshrG6K2boKAnCQUvT5SX79cP9nPgS2s1afzY1hg@mail.gmail.com>
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
To: syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>
Cc: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000e1b675065ba07abd"

--000000000000e1b675065ba07abd
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Sep 2026 08:19:24 -0700, syzbot wrote:
> syzbot found the following issue on:
> ...
> possible deadlock in ovl_create_object

Follow-up to my earlier note: I reproduced this with the C reproducer.

The cycle is not an overlayfs bug by itself. block2mtd_setup() opens the
named block device (VFS path walk) while still under param_lock and the
kernfs write path. When that write arrives via splice, a pipe mutex is
held as well. That nests under already (the other way) ordered locks with
overlay sb_writers / ovl_i_mutex.

The attached patch drops param_lock and defers the open to a workqueue
(still synchronous via wait_for_completion), so the VFS walk does not
run under that stack. Local testing with the syzbot C repro: lockdep
warning before the patch, clean after.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

Please consider the patch for linux-mtd.

On Thu, 17 Sept 2026 at 01:18, Chris Roy <iam@thechris.in> wrote:
>
> On Thu, 17 Sept 2026 at 01:10, syzbot
> <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    654ae5d73c05 Merge tag 'drm-fixes-2026-09-05' of https://g..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11860cf9580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=7cab6a19619f1b8efc00
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
>
> I am investigating this report and working on reproducing the lockdep
> cycle and identifying the root cause. I will follow up with findings
> and a proposed fix shortly.
>
> Regards,
> - Chris
>
> "But how could you live and have no story to tell?"

--000000000000e1b675065ba07abd
Content-Type: text/x-diff; charset="US-ASCII"; 
	name="0001-mtd-block2mtd-defer-device-open-out-of-param-sysfs-w.patch"
Content-Disposition: attachment; 
	filename="0001-mtd-block2mtd-defer-device-open-out-of-param-sysfs-w.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mu4mcdaa0>
X-Attachment-Id: f_mu4mcdaa0

RnJvbSBjMzk1MzUwNjZmNTNkOTk4YzcxNjQ4ODI3M2U4Njc2MWJiOGUyYWRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpcyBSb3kgPGlhbUB0aGVjaHJpcy5pbj4KRGF0ZTogV2Vk
LCAxNiBTZXAgMjAyNiAyMTowOTo0OSArMDAwMApTdWJqZWN0OiBbUEFUQ0hdIG10ZDogYmxvY2sy
bXRkOiBkZWZlciBkZXZpY2Ugb3BlbiBvdXQgb2YgcGFyYW0vc3lzZnMgd3JpdGUKCmJsb2NrMm10
ZF9zZXR1cCgpIGlzIGNhbGxlZCBmcm9tIHRoZSBtb2R1bGUtcGFyYW1ldGVyIHdyaXRlIHBhdGgK
d2hpbGUgcGFyYW1fbG9jayBpcyBoZWxkLCBhbmQgZnJvbSBpbnNpZGUga2VybmZzX2ZvcF93cml0
ZV9pdGVyCih3aGljaCBob2xkcyB0aGUga2VybmZzIGlub2RlIG11dGV4KS4gV2hlbiB0aGF0IHdy
aXRlIGFycml2ZXMgdmlhCnNwbGljZSwgYSBwaXBlIG11dGV4IGlzIGhlbGQgYXMgd2VsbC4KClRo
ZSBzZXR1cCBwYXRoIHRoZW4gb3BlbnMgdGhlIG5hbWVkIGJsb2NrIGRldmljZSB3aXRoCmJkZXZf
ZmlsZV9vcGVuX2J5X3BhdGgoKSwgd2hpY2ggd2Fsa3MgdGhlIFZGUy4gVGhhdCBuZXN0cyBpbm9k
ZSAvCm92ZXJsYXkgZGlyZWN0b3J5IGxvY2tzIGFuZCBzYl93cml0ZXJzIHVuZGVyIHRoZSBsb2Nr
cyBhYm92ZSBhbmQKY3JlYXRlcyBhIGxvY2tkZXAgY3ljbGUsIGZvciBleGFtcGxlOgoKICBzYl93
cml0ZXJzIC0+IHBpcGUgLT4ga2VybmZzL3BhcmFtIC0+IG92bF9pX211dGV4IC0+IHNiX3dyaXRl
cnMKCnN5emJvdCByZXByb2R1Y2VzIGl0IGJ5IHNwbGljaW5nIGludG8gYW4gb3ZlcmxheSBmaWxl
LCBzcGxpY2luZyBhbgpvdmVybGF5IHBhdGggaW50byAvc3lzL21vZHVsZS9ibG9jazJtdGQvcGFy
YW1ldGVycy9ibG9jazJtdGQsIHRoZW4KY3JlYXRpbmcgYSBmaWxlIG9uIHRoZSBvdmVybGF5LgoK
RHJvcCBwYXJhbV9sb2NrIGFuZCBydW4gdGhlIG9wZW4gb24gYSB3b3JrcXVldWUgc28gVkZTIGxv
Y2tpbmcgaXMKbm90IG5lc3RlZCB1bmRlciB0aGUgcGFyYW1ldGVyL3N5c2ZzL3BpcGUgc3RhY2su
IEtlZXAgdGhlIGNhbGwKc3luY2hyb25vdXMgd2l0aCB3YWl0X2Zvcl9jb21wbGV0aW9uKCkuIFBy
b3RlY3QgdGhlIGRldmljZSBsaXN0IGFuZAp0aGUgZWFybHktYm9vdCBwYXJhbWxpbmUgYnVmZmVy
IHdpdGggYSBsb2NhbCBtdXRleCB0aGF0IGlzIG5ldmVyCmhlbGQgYWNyb3NzIGEgcGF0aCBsb29r
dXAuCgpSZXBvcnRlZC1ieTogc3l6Ym90KzdjYWI2YTE5NjE5ZjFiOGVmYzAwQHN5emthbGxlci5h
cHBzcG90bWFpbC5jb20KQ2xvc2VzOiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/
ZXh0aWQ9N2NhYjZhMTk2MTlmMWI4ZWZjMDAKU2lnbmVkLW9mZi1ieTogQ2hyaXMgUm95IDxpYW1A
dGhlY2hyaXMuaW4+Ci0tLQogZHJpdmVycy9tdGQvZGV2aWNlcy9ibG9jazJtdGQuYyB8IDEwMyAr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDgzIGluc2Vy
dGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL2Rldmlj
ZXMvYmxvY2sybXRkLmMgYi9kcml2ZXJzL210ZC9kZXZpY2VzL2Jsb2NrMm10ZC5jCmluZGV4IDAz
ZTgwYjJjNC4uNGFiNGMzMWEyIDEwMDY0NAotLS0gYS9kcml2ZXJzL210ZC9kZXZpY2VzL2Jsb2Nr
Mm10ZC5jCisrKyBiL2RyaXZlcnMvbXRkL2RldmljZXMvYmxvY2sybXRkLmMKQEAgLTI3LDYgKzI3
LDggQEAKICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CiAjaW5jbHVkZSA8bGludXgvbXRkL210ZC5o
PgogI2luY2x1ZGUgPGxpbnV4L211dGV4Lmg+CisjaW5jbHVkZSA8bGludXgvd29ya3F1ZXVlLmg+
CisjaW5jbHVkZSA8bGludXgvY29tcGxldGlvbi5oPgogI2luY2x1ZGUgPGxpbnV4L21vdW50Lmg+
CiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgogI2luY2x1ZGUgPGxpbnV4L21ham9yLmg+CkBAIC00
NSw2ICs0Nyw3IEBAIHN0cnVjdCBibG9jazJtdGRfZGV2IHsKIAogLyogU3RhdGljIGluZm8gYWJv
dXQgdGhlIE1URCwgdXNlZCBpbiBjbGVhbnVwX21vZHVsZSAqLwogc3RhdGljIExJU1RfSEVBRChi
bGttdGRfZGV2aWNlX2xpc3QpOworc3RhdGljIERFRklORV9NVVRFWChibG9jazJtdGRfbXV0ZXgp
OwogCiAKIHN0YXRpYyBzdHJ1Y3QgcGFnZSAqcGFnZV9yZWFkKHN0cnVjdCBhZGRyZXNzX3NwYWNl
ICptYXBwaW5nLCBwZ29mZl90IGluZGV4KQpAQCAtMzI5LDcgKzMzMiw5IEBAIHN0YXRpYyBzdHJ1
Y3QgYmxvY2sybXRkX2RldiAqYWRkX2RldmljZShjaGFyICpkZXZuYW1lLCBpbnQgZXJhc2Vfc2l6
ZSwKIAkJZ290byBlcnJfZGVzdHJveV9tdXRleDsKIAl9CiAKKwltdXRleF9sb2NrKCZibG9jazJt
dGRfbXV0ZXgpOwogCWxpc3RfYWRkKCZkZXYtPmxpc3QsICZibGttdGRfZGV2aWNlX2xpc3QpOwor
CW11dGV4X3VubG9jaygmYmxvY2sybXRkX211dGV4KTsKIAlwcl9pbmZvKCJtdGQlZDogWyVzXSBl
cmFzZV9zaXplID0gJWRLaUIgWyVkXVxuIiwKIAkJZGV2LT5tdGQuaW5kZXgsCiAJCWxhYmVsID8g
bGFiZWwgOiBkZXYtPm10ZC5uYW1lICsgc3RybGVuKCJibG9jazJtdGQ6ICIpLApAQCAtNDYyLDMw
ICs0NjcsNzcgQEAgc3RhdGljIGludCBibG9jazJtdGRfc2V0dXAyKGNvbnN0IGNoYXIgKnZhbCkK
IH0KIAogCi1zdGF0aWMgaW50IGJsb2NrMm10ZF9zZXR1cChjb25zdCBjaGFyICp2YWwsIGNvbnN0
IHN0cnVjdCBrZXJuZWxfcGFyYW0gKmtwKQorCitzdHJ1Y3QgYmxvY2sybXRkX3NldHVwX3dvcmsg
eworCXN0cnVjdCB3b3JrX3N0cnVjdCB3b3JrOworCWNoYXIgKnZhbDsKKwlzdHJ1Y3QgY29tcGxl
dGlvbiBkb25lOworCWludCByZXQ7Cit9OworCitzdGF0aWMgdm9pZCBibG9jazJtdGRfc2V0dXBf
d29ya2ZuKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIHsKLSNpZmRlZiBNT0RVTEUKLQlyZXR1
cm4gYmxvY2sybXRkX3NldHVwMih2YWwpOwotI2Vsc2UKLQkvKiBJZiBtb3JlIHBhcmFtZXRlcnMg
YXJlIGxhdGVyIHBhc3NlZCBpbiB2aWEKLQkgICAvc3lzL21vZHVsZS9ibG9jazJtdGQvcGFyYW1l
dGVycy9ibG9jazJtdGQKLQkgICBhbmQgYmxvY2sybXRkX2luaXQoKSBoYXMgYWxyZWFkeSBiZWVu
IGNhbGxlZCwKLQkgICB3ZSBjYW4gcGFyc2UgdGhlIGFyZ3VtZW50IG5vdy4gKi8KKwlzdHJ1Y3Qg
YmxvY2sybXRkX3NldHVwX3dvcmsgKncgPQorCQljb250YWluZXJfb2Yod29yaywgc3RydWN0IGJs
b2NrMm10ZF9zZXR1cF93b3JrLCB3b3JrKTsKKworCXctPnJldCA9IGJsb2NrMm10ZF9zZXR1cDIo
dy0+dmFsKTsKKwljb21wbGV0ZSgmdy0+ZG9uZSk7Cit9CisKKy8qCisgKiBSdW4gZGV2aWNlIHNl
dHVwIG91dHNpZGUgdGhlIG1vZHVsZS1wYXJhbWV0ZXIgLyBrZXJuZnMgd3JpdGUgcGF0aC4KKyAq
IFRob3NlIHBhdGhzIGhvbGQgcGFyYW1fbG9jayBhbmQgdGhlIGtlcm5mcyBpbm9kZSBtdXRleCAo
YW5kLCB3aGVuIHRoZQorICogd3JpdGUgYXJyaXZlcyB2aWEgc3BsaWNlLCBhIHBpcGUgbXV0ZXgp
LiBPcGVuaW5nIGEgYmxvY2sgZGV2aWNlIGRvZXMKKyAqIFZGUyBsb29rdXBzIGFuZCBtdXN0IG5v
dCBuZXN0IHVuZGVyIHRoYXQgc3RhY2suCisgKi8KK3N0YXRpYyBpbnQgYmxvY2sybXRkX3NldHVw
X2RlZmVyKGNvbnN0IGNoYXIgKnZhbCkKK3sKKwlzdHJ1Y3QgYmxvY2sybXRkX3NldHVwX3dvcmsg
dyA9IHsKKwkJLnJldCA9IDAsCisJfTsKKworCXcudmFsID0ga3N0cmR1cCh2YWwsIEdGUF9LRVJO
RUwpOworCWlmICghdy52YWwpCisJCXJldHVybiAtRU5PTUVNOworCisJaW5pdF9jb21wbGV0aW9u
KCZ3LmRvbmUpOworCUlOSVRfV09SSygmdy53b3JrLCBibG9jazJtdGRfc2V0dXBfd29ya2ZuKTsK
KwlzY2hlZHVsZV93b3JrKCZ3LndvcmspOworCXdhaXRfZm9yX2NvbXBsZXRpb24oJncuZG9uZSk7
CisJa2ZyZWUody52YWwpOworCXJldHVybiB3LnJldDsKK30KIAotCWlmIChibG9jazJtdGRfaW5p
dF9jYWxsZWQpCi0JCXJldHVybiBibG9jazJtdGRfc2V0dXAyKHZhbCk7CitzdGF0aWMgaW50IGJs
b2NrMm10ZF9zZXR1cChjb25zdCBjaGFyICp2YWwsIGNvbnN0IHN0cnVjdCBrZXJuZWxfcGFyYW0g
KmtwKQoreworCWludCByZXQgPSAwOwogCi0JLyogRHVyaW5nIGVhcmx5IGJvb3Qgc3RhZ2UsIHdl
IG9ubHkgc2F2ZSB0aGUgcGFyYW1ldGVycwotCSAgIGhlcmUuIFdlIG11c3QgcGFyc2UgdGhlbSBs
YXRlcjogaWYgdGhlIHBhcmFtIHBhc3NlZAotCSAgIGZyb20ga2VybmVsIGJvb3QgY29tbWFuZCBs
aW5lLCBibG9jazJtdGRfc2V0dXAoKSBpcwotCSAgIGNhbGxlZCBzbyBlYXJseSB0aGF0IGl0IGlz
IG5vdCBwb3NzaWJsZSB0byByZXNvbHZlCi0JICAgdGhlIGRldmljZSAoZXZlbiBrbWFsbG9jKCkg
ZmFpbHMpLiBEZXRlciB0aGF0IHdvcmsgdG8KLQkgICBibG9jazJtdGRfc2V0dXAyKCkuICovCisJ
aWYgKCF0cnlfbW9kdWxlX2dldChrcC0+bW9kKSkKKwkJcmV0dXJuIC1FTk9ERVY7CiAKLQlzdHJz
Y3B5KGJsb2NrMm10ZF9wYXJhbWxpbmUsIHZhbCwgc2l6ZW9mKGJsb2NrMm10ZF9wYXJhbWxpbmUp
KTsKKwkvKgorCSAqIERyb3AgcGFyYW1fbG9jayBiZWZvcmUgc2NoZWR1bGluZy4gVGhlIGFjdHVh
bCBvcGVuIHJ1bnMgb24gYQorCSAqIHdvcmtxdWV1ZSBzbyBpdCBpcyBhbHNvIG91dHNpZGUga2Vy
bmZzX2ZvcF93cml0ZV9pdGVyJ3MgaW5vZGUKKwkgKiBtdXRleCAoYW5kIGFueSBwaXBlIGxvY2sg
ZnJvbSBzcGxpY2UpLgorCSAqLworCWtlcm5lbF9wYXJhbV91bmxvY2soa3AtPm1vZCk7CiAKLQly
ZXR1cm4gMDsKKyNpZmRlZiBNT0RVTEUKKwlyZXQgPSBibG9jazJtdGRfc2V0dXBfZGVmZXIodmFs
KTsKKyNlbHNlCisJaWYgKGJsb2NrMm10ZF9pbml0X2NhbGxlZCkgeworCQlyZXQgPSBibG9jazJt
dGRfc2V0dXBfZGVmZXIodmFsKTsKKwl9IGVsc2UgeworCQltdXRleF9sb2NrKCZibG9jazJtdGRf
bXV0ZXgpOworCQlzdHJzY3B5KGJsb2NrMm10ZF9wYXJhbWxpbmUsIHZhbCwgc2l6ZW9mKGJsb2Nr
Mm10ZF9wYXJhbWxpbmUpKTsKKwkJbXV0ZXhfdW5sb2NrKCZibG9jazJtdGRfbXV0ZXgpOworCX0K
ICNlbmRpZgorCisJa2VybmVsX3BhcmFtX2xvY2soa3AtPm1vZCk7CisJbW9kdWxlX3B1dChrcC0+
bW9kKTsKKworCXJldHVybiByZXQ7CiB9CiAKIApAQCAtNDk3LDkgKzU0OSwxOCBAQCBzdGF0aWMg
aW50IF9faW5pdCBibG9jazJtdGRfaW5pdCh2b2lkKQogCWludCByZXQgPSAwOwogCiAjaWZuZGVm
IE1PRFVMRQotCWlmIChzdHJsZW4oYmxvY2sybXRkX3BhcmFtbGluZSkpCi0JCXJldCA9IGJsb2Nr
Mm10ZF9zZXR1cDIoYmxvY2sybXRkX3BhcmFtbGluZSk7CisJbXV0ZXhfbG9jaygmYmxvY2sybXRk
X211dGV4KTsKKwlpZiAoc3RybGVuKGJsb2NrMm10ZF9wYXJhbWxpbmUpKSB7CisJCWNoYXIgYnVm
W3NpemVvZihibG9jazJtdGRfcGFyYW1saW5lKV07CisKKwkJc3Ryc2NweShidWYsIGJsb2NrMm10
ZF9wYXJhbWxpbmUsIHNpemVvZihidWYpKTsKKwkJbXV0ZXhfdW5sb2NrKCZibG9jazJtdGRfbXV0
ZXgpOworCQkvKiBpbml0IGNvbnRleHQ6IG5vIGtlcm5mcy9wYXJhbSBsb2NrcyBoZWxkICovCisJ
CXJldCA9IGJsb2NrMm10ZF9zZXR1cDIoYnVmKTsKKwkJbXV0ZXhfbG9jaygmYmxvY2sybXRkX211
dGV4KTsKKwl9CiAJYmxvY2sybXRkX2luaXRfY2FsbGVkID0gMTsKKwltdXRleF91bmxvY2soJmJs
b2NrMm10ZF9tdXRleCk7CiAjZW5kaWYKIAogCXJldHVybiByZXQ7CkBAIC01MTAsNiArNTcxLDcg
QEAgc3RhdGljIHZvaWQgYmxvY2sybXRkX2V4aXQodm9pZCkKIHsKIAlzdHJ1Y3QgbGlzdF9oZWFk
ICpwb3MsICpuZXh0OwogCisJbXV0ZXhfbG9jaygmYmxvY2sybXRkX211dGV4KTsKIAkvKiBSZW1v
dmUgdGhlIE1URCBkZXZpY2VzICovCiAJbGlzdF9mb3JfZWFjaF9zYWZlKHBvcywgbmV4dCwgJmJs
a210ZF9kZXZpY2VfbGlzdCkgewogCQlzdHJ1Y3QgYmxvY2sybXRkX2RldiAqZGV2ID0gbGlzdF9l
bnRyeShwb3MsIHR5cGVvZigqZGV2KSwgbGlzdCk7CkBAIC01MjIsNiArNTg0LDcgQEAgc3RhdGlj
IHZvaWQgYmxvY2sybXRkX2V4aXQodm9pZCkKIAkJbGlzdF9kZWwoJmRldi0+bGlzdCk7CiAJCWJs
b2NrMm10ZF9mcmVlX2RldmljZShkZXYpOwogCX0KKwltdXRleF91bmxvY2soJmJsb2NrMm10ZF9t
dXRleCk7CiB9CiAKIGxhdGVfaW5pdGNhbGwoYmxvY2sybXRkX2luaXQpOwotLSAKMi40My4wCgo=
--000000000000e1b675065ba07abd--
