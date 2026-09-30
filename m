Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4972A475344
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809074; cv=none; b=L2ZsykL1CWk0fZuS69VHoD9U5erlxjP7EfEpHCc7xizbqmpjnAJjsABjdqNNbfmse7JpI/FTuwZBLrceaiBZWYK7M0KsxYXCr0Q1EXzpcv8XfGQ5DMkdkS6yUIHRKPHdaJGn/Gmjr3QDKTTvHx3sYEANwrRG/wSLECJYquwQGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809074; c=relaxed/simple;
	bh=e1Dw2MfLYZ9WyibJ5wl4o8xcjxbgrNOZGiJN8gdlJM4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=lP3CVihuYZ80wcCkrsJCbbTxMUsaSMfwEYG9jxysptDT5WzNVjxFeEKcnOFAWLFsMD6cmpCQiir5OJIMtCCal4uLVFXkRvtoBNyRexLHzh5fBfkZh71e/koNIrFjpXTZfCaBmpyL5/MbJEtQw3wMEwgO8sjzsqWfrNkFoTc6eAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=jEPUlPTn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hQruLrhg; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="jEPUlPTn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hQruLrhg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AEE061D0010A;
	Wed, 30 Sep 2026 18:57:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 30 Sep 2026 18:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790809068; x=1790895468; bh=3kwmpd6iWD
	6CQXah2DoD0FsegnqZez4GFU2bIPrIiNM=; b=jEPUlPTnKjqZIXAo6yzu7mLk5c
	TVpbB3xEBRI2L/LnNJOtN1Py1t9bKh3wlRDnJ+jQGGipwEfmlgrcTKkplznG1bNB
	DT3a5nNWQtiKQxbHrsfeb842FKPtc5iFOY50YW4ZDTePr46cK3RzRtW/k9enWpXF
	KIYzorC31psEEnaQAXqkDqn98KBI7tLo6AEO/wMtZQCEWjocVTXaqnX1N+2aL/72
	D9NLRLWJKhPXy3Yjli3IdCPIa9u4TauxYq3Oo7AICVdV3xz7q98FXEyugy0dlIz/
	HhHnX82lo1v/MJADHR4nZhDzPhZZh2FnlXKdUNCdtHTD8VTwm97N7g/dyxSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790809068; x=1790895468; bh=3kwmpd6iWD6CQXah2DoD0FsegnqZez4GFU2
	bIPrIiNM=; b=hQruLrhgYKAuCGi+e8P70MrDFCLoOaHMDVuKtNzOAVKyfqOLWme
	I9eNhC5ms7tW3HLPFlR0gshqFMuG43NJ4w6rquYPzFqO8fZGKMuZEj5QC+xXftdO
	f6afIw1ndnZEkb3c4xh96SGJGNX2fvQHIX92Z6IjovMrcZcAJPxoPyZU2M5Vzsaz
	kGNZwQhWR+/fCLPcpUZcP/TINb7jk0GizCZys5N6lwNfIkwJla6zDmkMreOzMEyz
	+ppv/zvVZ2YWIGUKwkDsagABf7u5aziPV88MQyBgcKvh6jeEcwDp8VqLWxp//1Wc
	y/7p9RAlkXbjdP3juP0umtFa/vAMEf+dEZQ==
X-ME-Sender: <xms:7JO9aj8mASQ7NG_tiG4p4KGfPOsmQMZcNhhEjRbN4GxN49qBpUpzVg>
    <xme:7JO9ahMNj8ZgMkx6eNUL72GIc8Gc_4RxXXsimjXF58lZkzB2nWJnkdiCCvX1KJG4w
    69vt3Q4XYGHARb5T3OFQEfpOd7Lo99sNWVj_1lJRe7xNXm4va2X>
X-ME-Received: <xmr:7JO9ahFgQc1mkouj_Z3rXZSdbN4HugwXeEVrF_gOKJjV7pNZnDpq_zCYxjh6ppYNoopZnVcVyDJJ3crgCMnzBJALfbraDfZWaiTMb8cOQ7ren54J_A>
X-ME-Proxy-Cause: dmFkZTFDc9Pp/xRpvydum+XdVxu4n35rco4JpV6xHT/JTs1rJzWP+qYNNHxWgT1N/53Y4X
    4UIx0j29YPNS/gFhZ9xxexXQKC9rs1jedgi2Mv6FQb/GJUXhqezt4N/N0n+pp6X7UxVgW1
    LRlwK2yAAp+v/gwUiFFqOeFAwXm0WhSTo2aCvukjp5slA8lPjicsIfHt9hWR4TOa3zmPJ1
    CHXCp+ygWDNqB0BDSKZ29HHYZEArpFITUymmSadhhhCikQ3zhQ7QwPd59RXfmGKmaaMdkJ
    1KqZxdDBsZs6UPUbR16LnhW6HNAeydMaC4RzaeQ6cYFildtJS2YwiZBLly8iRuuV14Jnsx
    EtG2FiRlw+TY3X5KSQWK+ZZcP1MdCmJljCaGOMgpAwihMmjoWbitxlrfLGkne5dmb5uPfJ
    JneLl9aOJRznt+CoDnTLRhBbA8lOIiwRkDHSkDW5tw2AhyA9RSmSeD6dkP4QMovRKyAq3I
    Bz99bNhMWLpNBWy0Nc5z62BVNbLmHTj7rVgv6I7tsdEZ9M0QefTCsBHDjqj4dGk43JV0fo
    G88bSAMX4hk3ivzlsdT1YuJvaWdwLideQGC84ucU6w3oneKiEGZ9wIM60sT9p+NUnBIMWJ
    vnbH+6DTAZ5z+hGjrsbZLxFmX7s95bYMM/JZQ3NK+pXSpY/U2FvSvI215Dzg
X-ME-Proxy: <xmx:7JO9avSGzXIpxc9ujL4jxZb2lb4NMGbrO9DHTJ6c2tgDSmZmhO7V9Q>
    <xmx:7JO9auv16t_iL2MFVTzSQs8AFFTeCtzESgEWV2-eg4vkHe38Nha_Sw>
    <xmx:7JO9anIYEeZO2gBYCco1whUiaaUEE6wvYPDdECcTxWCRGWvWh_nZhA>
    <xmx:7JO9ajkvGf-YD3cNiip7XA94uj60BmFhsrYy72YXl35VZjlkJ1gj9Q>
    <xmx:7JO9atQgEdCB7C7wl1uOinZ5X17fZjz5NsooUZQ2tqJBqMJTosUmWCh_>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 18:57:46 -0400 (EDT)
Content-Type: multipart/mixed; boundary="------------LiDpeCnDKX8wtFJS7GYqtCBJ"
Message-ID: <e75cf549-07a6-4095-bbf8-8caff7a3338b@bsbernd.com>
Date: Thu, 1 Oct 2026 00:57:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fuse: HANDLE_KILLPRIV_V2 does not kill suid/sgid on fallocate()
 and copy_file_range()
To: Mitar <mmitar@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
References: <CAKLmikMhOYpGEw6uCqX_Bm0JPEg-4FhdJMNa9+tgtw3-Kf+eZg@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <CAKLmikMhOYpGEw6uCqX_Bm0JPEg-4FhdJMNa9+tgtw3-Kf+eZg@mail.gmail.com>

This is a multi-part message in MIME format.
--------------LiDpeCnDKX8wtFJS7GYqtCBJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/30/26 23:45, Mitar wrote:
> Hi!
> 
> While adding FUSE_HANDLE_KILLPRIV_V2 support to a go-fuse based
> server, I noticed that with it negotiated, fallocate() and
> copy_file_range() by a caller without CAP_FSETID no longer clear the
> setuid and setgid bits of the file they modify, and that the server
> has no way to learn that it should clear them itself.
> 
> The kernel makes the decision, but drops it on the way.
> fuse_file_fallocate() and __fuse_copy_file_range() both call
> file_modified() before sending the request, which ends in
> fuse_setattr() with ATTR_KILL_SUID and ATTR_KILL_SGID. Since commit
> 8981bdfda744 ("fuse: don't send ATTR_MODE to kill suid/sgid for
> handle_killpriv_v2"), fuse_setattr() drops those when
> fc->handle_killpriv_v2 is set, expecting the server to kill the bits
> when the WRITE which follows arrives. But no WRITE follows
> FUSE_FALLOCATE or FUSE_COPY_FILE_RANGE, and neither carries such a
> flag. All the server sees is an empty SETATTR before the request,
> which it cannot tell apart from the one it gets when only
> ATTR_KILL_PRIV was asked for.
> 
> For "fallocate -l 8192 f" run by an unprivileged user, on a file with
> mode 06777 which they may write to, the server receives:
> 
>   GETXATTR  "security.capability" -> ENODATA
>   SETATTR   valid=0
>   FALLOCATE offset=0 length=8192 mode=0
> 
> and the file keeps mode 06777. Without FUSE_HANDLE_KILLPRIV_V2, the
> same command clears both bits, since fuse_setattr() then turns the
> request into a SETATTR of the mode. I verified the fallocate() case.
> The copy_file_range() case is from reading the code, as the server I
> tested does not implement FUSE_COPY_FILE_RANGE.
> 
> This matters beyond the mode looking wrong: fallocate() with
> FALLOC_FL_ZERO_RANGE or FALLOC_FL_PUNCH_HOLE, and copy_file_range()
> even more so, change what the file holds. So somebody who may write to
> a setuid file can replace its contents and keep the setuid bit, which
> is what killing the bits is there to prevent.
> 
> It looks like an interaction between changes rather than a choice.
> Commit fe0da9c09b2d ("fuse: copy_file_range needs to strip setuid bits
> and update timestamps") made copy_file_range() kill the bits in 2019,
> which stopped working on FUSE_HANDLE_KILLPRIV_V2 connections with
> 8981bdfda744 in 2020. Commit 4a6f278d4827 ("fuse: add file_modified()
> to fallocate") added the same to fallocate() in 2022, which takes
> effect only without FUSE_HANDLE_KILLPRIV_V2. As far as I can tell from
> its source, virtiofsd with --killpriv-v2 has the same gap: it drops
> CAP_FSETID for write, open and setattr when asked to, and calls
> fallocate() and copy_file_range() as they are.
> 
> I think we should pass the decision with the request, as for WRITE and
> OPEN. For FUSE_FALLOCATE, a new FUSE_FALLOCATE_KILL_SUIDGID could go
> into the currently unused fuse_fallocate_in.padding. For
> FUSE_COPY_FILE_RANGE, it would need a new field, or a bit in
> fuse_copy_file_range_in.flags behind a new INIT flag: servers pass
> .flags on to copy_file_range(2) as it is (virtiofsd does), which fails
> with EINVAL on any bit, so a new bit there cannot be sent to a server
> which did not ask for it.
> 
> What do you think?
> 

I had actually noticed this with recent test additions in libfuse and 
had to add workarounds (on the day exactly one month ago). 
Unfortunately had been too busy to post the kernel patch yet.

libfuse commits
daa6cb7f6996 — "test: check the KILLPRIV_V2 kill-suidgid flags reach the filesystem"

and 

60ab8c0c35de ("test: check a write through passthrough_hp clears suid/sgid")

When testing the latter commit I had noticed the issue.

Could you try the attached patch? Right now totally untested, 
I can test and send it out earliest during the weekend.


Thanks,
Bernd


--------------LiDpeCnDKX8wtFJS7GYqtCBJ
Content-Type: text/plain; charset=UTF-8; name="fuse-killpriv-v2-fallocate"
Content-Disposition: attachment; filename="fuse-killpriv-v2-fallocate"
Content-Transfer-Encoding: base64

ZnVzZToga2lsbCBzdWlkL3NnaWQgb24gZmFsbG9jYXRlIGFuZCBjb3B5X2ZpbGVfcmFuZ2Ug
d2l0aCBLSUxMUFJJVl9WMgoKRnJvbTogQmVybmQgU2NodWJlcnQgPGJlcm5kQGJzYmVybmQu
Y29tPgoKV2l0aCBGVVNFX0hBTkRMRV9LSUxMUFJJVl9WMiwgZnVzZV9zZXRhdHRyKCkgZHJv
cHMgdGhlIG1vZGUgY2hhbmdlIHRoYXQKZmlsZV9yZW1vdmVfcHJpdnMoKSBhc2tzIGZvciBh
bmQgcmVsaWVzIG9uIHRoZSBzZXJ2ZXIgdG8gY2xlYXIgdGhlIGJpdHMKd2hlbiBpdCBoYW5k
bGVzIHRoZSBmb2xsb3dpbmcgV1JJVEUgcmVxdWVzdCAoRlVTRV9XUklURV9LSUxMX1NVSURH
SUQpLgpmYWxsb2NhdGUoKSBhbmQgY29weV9maWxlX3JhbmdlKCkgc2VuZCBubyBXUklURSwg
YW5kIHRoZSBTRVRBVFRSIHNlbnQKZnJvbSBmaWxlX21vZGlmaWVkKCkgY2FycmllcyBubyBr
aWxsIGZsYWcuIEEgY2FsbGVyIHdpdGhvdXQgQ0FQX0ZTRVRJRApjYW4gdGhlcmVmb3JlIGNo
YW5nZSB0aGUgY29udGVudHMgb2YgYSBzZXR1aWQgZmlsZSB3aGlsZSB0aGUgc2V0dWlkIGJp
dApzdGF5cyBzZXQ7IHdyaXRlKCkgb24gdGhlIHNhbWUgZmlsZSBjbGVhcnMgaXQuCgpTZW5k
IEZBVFRSX0tJTExfU1VJREdJRCBpbiB0aGF0IFNFVEFUVFIuIFRoZSBWRlMgc2V0cyBBVFRS
X0tJTExfU1VJRCBhbmQKQVRUUl9LSUxMX1NHSUQgb25seSBhZnRlciBpdHMgb3duIENBUF9G
U0VUSUQgY2hlY2ssIHNvIGNhcGFibGUoKSBpcyBub3QKdGVzdGVkIGFnYWluLgoKRml4ZXM6
IDg5ODFiZGZkYTc0NCAoImZ1c2U6IGRvbid0IHNlbmQgQVRUUl9NT0RFIHRvIGtpbGwgc3Vp
ZC9zZ2lkIGZvciBoYW5kbGVfa2lsbHByaXZfdjIiKQpTaWduZWQtb2ZmLWJ5OiBCZXJuZCBT
Y2h1YmVydCA8YmVybmRAYnNiZXJuZC5jb20+Ci0tLQogZnMvZnVzZS9kaXIuYyAgICB8ICAg
MTMgKysrKysrKysrKystLQogZnMvZnVzZS9maWxlLmMgICB8ICAgIDMgKystCiBmcy9mdXNl
L2Z1c2VfaS5oIHwgICAgMiArLQogMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGlyLmMgYi9mcy9mdXNl
L2Rpci5jCmluZGV4IGU0OWI0ZTg3NGIxNS4uZmYwNzhjYzJjZWE1IDEwMDY0NAotLS0gYS9m
cy9mdXNlL2Rpci5jCisrKyBiL2ZzL2Z1c2UvZGlyLmMKQEAgLTIxNDMsNyArMjE0Myw3IEBA
IGludCBmdXNlX2ZsdXNoX3RpbWVzKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmdXNl
X2ZpbGUgKmZmKQogICogYW5kIHRoZSBhY3R1YWwgdHJ1bmNhdGlvbiBieSBoYW5kLgogICov
CiBpbnQgZnVzZV9kb19zZXRhdHRyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3Qg
ZGVudHJ5ICpkZW50cnksCi0JCSAgICBzdHJ1Y3QgaWF0dHIgKmF0dHIsIHN0cnVjdCBmaWxl
ICpmaWxlKQorCQkgICAgc3RydWN0IGlhdHRyICphdHRyLCBzdHJ1Y3QgZmlsZSAqZmlsZSwg
Ym9vbCBraWxsX3N1aWRnaWQpCiB7CiAJc3RydWN0IGlub2RlICppbm9kZSA9IGRfaW5vZGUo
ZGVudHJ5KTsKIAlzdHJ1Y3QgZnVzZV9tb3VudCAqZm0gPSBnZXRfZnVzZV9tb3VudChpbm9k
ZSk7CkBAIC0yMjMzLDYgKzIyMzMsMTMgQEAgaW50IGZ1c2VfZG9fc2V0YXR0cihzdHJ1Y3Qg
bW50X2lkbWFwICppZG1hcCwgc3RydWN0IGRlbnRyeSAqZGVudHJ5LAogCSAgICBhdHRyLT5p
YV92YWxpZCAmIChBVFRSX1VJRCB8IEFUVFJfR0lEKSkKIAkJaW5hcmcudmFsaWQgfD0gRkFU
VFJfS0lMTF9TVUlER0lEOwogCisJLyoKKwkgKiBmdXNlX3NldGF0dHIoKSBkcm9wcGVkIHRo
ZSBtb2RlIGNoYW5nZSBmb3IgdGhlIGtpbGwgcmVxdWVzdC4gVGhlIFZGUworCSAqIGFscmVh
ZHkgYXBwbGllZCB0aGUgQ0FQX0ZTRVRJRCBydWxlLCBzbyBubyBjYXBhYmxlKCkgdGVzdCBo
ZXJlLgorCSAqLworCWlmIChmYy0+aGFuZGxlX2tpbGxwcml2X3YyICYmIGtpbGxfc3VpZGdp
ZCkKKwkJaW5hcmcudmFsaWQgfD0gRkFUVFJfS0lMTF9TVUlER0lEOworCiAJaWYgKGF0dHIt
PmlhX3ZhbGlkICYgQVRUUl9TSVpFKSB7CiAJCS8qIEZvciBtYW5kYXRvcnkgbG9ja2luZyBp
biB0cnVuY2F0ZSAqLwogCQlpbmFyZy52YWxpZCB8PSBGQVRUUl9MT0NLT1dORVI7CkBAIC0y
MzI5LDYgKzIzMzYsNyBAQCBzdGF0aWMgaW50IGZ1c2Vfc2V0YXR0cihzdHJ1Y3QgbW50X2lk
bWFwICppZG1hcCwgc3RydWN0IGRlbnRyeSAqZW50cnksCiAJc3RydWN0IGlub2RlICppbm9k
ZSA9IGRfaW5vZGUoZW50cnkpOwogCXN0cnVjdCBmdXNlX2Nvbm4gKmZjID0gZ2V0X2Z1c2Vf
Y29ubihpbm9kZSk7CiAJc3RydWN0IGZpbGUgKmZpbGUgPSAoYXR0ci0+aWFfdmFsaWQgJiBB
VFRSX0ZJTEUpID8gYXR0ci0+aWFfZmlsZSA6IE5VTEw7CisJYm9vbCBraWxsX3N1aWRnaWQg
PSBmYWxzZTsKIAlpbnQgcmV0OwogCiAJaWYgKGZ1c2VfaXNfYmFkKGlub2RlKSkKQEAgLTIz
MzgsNiArMjM0Niw3IEBAIHN0YXRpYyBpbnQgZnVzZV9zZXRhdHRyKHN0cnVjdCBtbnRfaWRt
YXAgKmlkbWFwLCBzdHJ1Y3QgZGVudHJ5ICplbnRyeSwKIAkJcmV0dXJuIC1FQUNDRVM7CiAK
IAlpZiAoYXR0ci0+aWFfdmFsaWQgJiAoQVRUUl9LSUxMX1NVSUQgfCBBVFRSX0tJTExfU0dJ
RCkpIHsKKwkJa2lsbF9zdWlkZ2lkID0gdHJ1ZTsKIAkJYXR0ci0+aWFfdmFsaWQgJj0gfihB
VFRSX0tJTExfU1VJRCB8IEFUVFJfS0lMTF9TR0lEIHwKIAkJCQkgICAgQVRUUl9NT0RFKTsK
IApAQCAtMjM3MCw3ICsyMzc5LDcgQEAgc3RhdGljIGludCBmdXNlX3NldGF0dHIoc3RydWN0
IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdCBkZW50cnkgKmVudHJ5LAogCWlmICghYXR0ci0+
aWFfdmFsaWQpCiAJCXJldHVybiAwOwogCi0JcmV0ID0gZnVzZV9kb19zZXRhdHRyKGlkbWFw
LCBlbnRyeSwgYXR0ciwgZmlsZSk7CisJcmV0ID0gZnVzZV9kb19zZXRhdHRyKGlkbWFwLCBl
bnRyeSwgYXR0ciwgZmlsZSwga2lsbF9zdWlkZ2lkKTsKIAlpZiAoIXJldCkgewogCQkvKgog
CQkgKiBJZiBmaWxlc3lzdGVtIHN1cHBvcnRzIGFjbHMgaXQgbWF5IGhhdmUgdXBkYXRlZCBh
Y2wgeGF0dHJzIGluCmRpZmYgLS1naXQgYS9mcy9mdXNlL2ZpbGUuYyBiL2ZzL2Z1c2UvZmls
ZS5jCmluZGV4IDlhMzZkMDMyOWUyMi4uMjcyZTZmZGQ0OWUzIDEwMDY0NAotLS0gYS9mcy9m
dXNlL2ZpbGUuYworKysgYi9mcy9mdXNlL2ZpbGUuYwpAQCAtMjcwOCw3ICsyNzA4LDggQEAg
c3RhdGljIHZvaWQgZnVzZV9kb190cnVuY2F0ZShzdHJ1Y3QgZmlsZSAqZmlsZSkKIAlhdHRy
LmlhX2ZpbGUgPSBmaWxlOwogCWF0dHIuaWFfdmFsaWQgfD0gQVRUUl9GSUxFOwogCi0JZnVz
ZV9kb19zZXRhdHRyKGZpbGVfbW50X2lkbWFwKGZpbGUpLCBmaWxlX2RlbnRyeShmaWxlKSwg
JmF0dHIsIGZpbGUpOworCWZ1c2VfZG9fc2V0YXR0cihmaWxlX21udF9pZG1hcChmaWxlKSwg
ZmlsZV9kZW50cnkoZmlsZSksICZhdHRyLCBmaWxlLAorCQkJZmFsc2UpOwogfQogCiBzdGF0
aWMgaW5saW5lIGxvZmZfdCBmdXNlX3JvdW5kX3VwKHN0cnVjdCBmdXNlX2Nvbm4gKmZjLCBs
b2ZmX3Qgb2ZmKQpkaWZmIC0tZ2l0IGEvZnMvZnVzZS9mdXNlX2kuaCBiL2ZzL2Z1c2UvZnVz
ZV9pLmgKaW5kZXggYzhkNGM1ZjNhZjdlLi44MzcyN2ZmZmFhNjggMTAwNjQ0Ci0tLSBhL2Zz
L2Z1c2UvZnVzZV9pLmgKKysrIGIvZnMvZnVzZS9mdXNlX2kuaApAQCAtMTE5MCw3ICsxMTkw
LDcgQEAgaW50IGZ1c2VfZmx1c2hfdGltZXMoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0
IGZ1c2VfZmlsZSAqZmYpOwogaW50IGZ1c2Vfd3JpdGVfaW5vZGUoc3RydWN0IGlub2RlICpp
bm9kZSwgc3RydWN0IHdyaXRlYmFja19jb250cm9sICp3YmMpOwogCiBpbnQgZnVzZV9kb19z
ZXRhdHRyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnks
Ci0JCSAgICBzdHJ1Y3QgaWF0dHIgKmF0dHIsIHN0cnVjdCBmaWxlICpmaWxlKTsKKwkJICAg
IHN0cnVjdCBpYXR0ciAqYXR0ciwgc3RydWN0IGZpbGUgKmZpbGUsIGJvb2wga2lsbF9zdWlk
Z2lkKTsKIAogdm9pZCBmdXNlX3VubG9ja19pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBi
b29sIGxvY2tlZCk7CiBib29sIGZ1c2VfbG9ja19pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2Rl
KTsK

--------------LiDpeCnDKX8wtFJS7GYqtCBJ--
