Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793653436;
	b=JXp3iUs5vCtknIDv48ON1meL4u6tva9bjlotJL8fUOJ3kzN8C9xwDVCVG895XBN7qKra
	 2kqCFQEih6zdXEx28UiwFSVLJSt4sc78I10R9Yrb5aXSHQ/GZae8PvrJFaDm2qE7+OCKL
	 OsT4jhWj09MLR4v+d3ZyeVcek+J+9z5dscw+WjRY/nRSsfHJ/c3GjykMbLNRp4aibRB7z
	 2c5qzdKUcP+6OMJowa5AkW1QOcS0fIVwAQKJFAOv4ns6j0L5rpQ9c7x03IgTJns+Xp3sW
	 28Th1ppKxDi5mawAvpBPpj5ekIgzElpPS6+3BpNkrzy00IhineFpAvjkYNF6uNgv+EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=YebZSF/Kl+cRxyBBQxMvp4KclRsEN0c74j2FIV9Omn0=;
	b=IQl/G2Y5YZUEDJt94nrZwFgcVEbzX2EsLLOXd/7/R5VwvXHZ/2XB7Md/p8KE1i6fln25
	 EdpNhimnAqcQYnkg9lJn85zoPH/vI0gmGOoy+BPCMCzB+I0Oz/TM36r3S6DqQ5PaIkmWT
	 rCwyV1UjtTmnSsx4FLkVAntwjUi4sCGoXrn+/jBb9utzK7s0T+iMJRUIKqphqWe2eNUNQ
	 R5nTBzFWzrhmoldQV9hrylMFgCcAZlfv5d+rY5ZwyG9tlJYnE4RB7zzQrwTANcRidQMcO
	 6MkO7g/DMvTMTNjhN6eZkuQx3F751GaCEsBoKm2Oyj8m7AKfAzzGZpAEf9mstPBD4nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=X3MiM7gx;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781D606A324
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 21:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5781D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=X3MiM7gx
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c45551fa84eso507969066b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 13:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793653433; x=1794258233; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YebZSF/Kl+cRxyBBQxMvp4KclRsEN0c74j2FIV9Omn0=;
        b=X3MiM7gx7hIxcG8+xOLQQaZjIjyyWiIR3DUEHuCwHV7OlpXhyGgjfDTKKUPXy0r3TA
         LNAm/RBNwBXQf5sbWpVDKn6T9/hOYCUCCXJSPp7v3+IXuz/S8pKC819qLFqefovXIJFV
         HyZHWkShy/oGHeicykY0gatVU8NDcrC+d/5Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793653433; x=1794258233;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YebZSF/Kl+cRxyBBQxMvp4KclRsEN0c74j2FIV9Omn0=;
        b=kHkpYYr4ixycy58uz0i/O3ffMnndA2U0JuI3ehDCPrlvcuXarQY2cGDLv6ZQvAr2+f
         hTMjNSVsOJmcFaSy1GX1gXqhnRTdcjS68XjAQQigu/TYQpyLaziEGpko33WI//TnQLMs
         sfsf7SRYKYRzrNg5GiTWzciod4yBBlMSdBvmqbAVhNAIziWhergi7qyjoC6rVhiNfCjg
         sSVt9lj+R00cewUpIH1P1R0dcddA8qfRYDMlG/nbvCoRkgYYo71ScNhlTHtQO87U3qWR
         GHjb6WEduoUDznsU8/QvpgaRH24YDkFNe/SssAyUOT+oVNYTqoxDamxAB1/j5vJ8SIei
         xfng==
X-Forwarded-Encrypted: i=1; AKwUvBw8I/z2O8e1ktznzNsz/mC635ujeEKF61JptIpqt0Ynufba2Aof8bcQNSO7IoQA4bJruzo7Tuqt6hzTVRHU@vger.kernel.org
X-Gm-Message-State: AFq9FYKGs2u2nYBvkckxHYk+LMVvHJooPUjyorbbRIPy8cSTkx8YYomz
	nkVcde/mEHDEBbRWCdwB+//GekEfDpMoFZQKMRJeXjoVa+FJPAD12m9XzUnjrSfBQf/I0+fBie0
	8XoFCCrEZTQ==
X-Gm-Gg: AYBFou0zwQDa7aYxADPiCSyyA3d2/8JAgbCQsXdM2vE8azG6und0AMR7+yknCxogPDf
	mSbVV5ENQXpso/5fN6bpYY5KL2VYISyYjqUtC0vyieLS6eogUYtGZmUNqHMD2Fmm9i7bpH+kt3w
	3oX8Ig0vgGnCgpi892jC4JIqAr1LW1YjPmQTN0VFq2CPIy9g/FSRx9B2sGuMo+gPexxqhClmXUo
	7v2TcC2cRc56SWKvJnYduc2ncMZjk592XNAkJzUDLtWskDiiFS03+dYG7Gh6dpLmmvemjx3Dnpd
	9XUFZTYLRfoD9aSdsrcXLLcwWRu8iLIYUc21hGspKA52ZqsplZqLCuqJvtFmYSEsa2Zzd7EWEsG
	zIlpZzN412ArmBaL96b2jHTwkfXrh9ef/1mGpTHgMCqKgWu2/+wXiu3cjoUT0tcclAnIi1iU8TH
	M1zi2vNbne/PTlrsBD8CBFFwTOkCkn2XLP5iXgoNOD85MoQIaLGM1P+ci2L7bnl1MXNi4R4in9f
	DRsuSmD1TA5vhK4o+yuxCb0lXbnnR8roxMaVD9oEUETqmb6dalKmjRsXe3xDh+dewdGazqprb72
	PB8mfalM3CZKboQuRp4QdBNbNVWaTg6oyn4RJBOMuT/jSJnPTBbL94MpqlTTR0n/ULD5D0ipueh
	IGQ==
X-Received: by 2002:a17:907:9811:b0:c46:a607:6922 with SMTP id a640c23a62f3a-c4ca7a41364mr925433366b.25.1793653433535;
        Mon, 02 Nov 2026 13:03:53 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebefc8c3sm23995966b.33.2026.11.02.13.03.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 13:03:52 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4682977f9aso426629366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 13:03:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByecvqHzUyvYxE+AshtBHrXK2He7jcl9mQH6U73x9LT5k+o/+9sX27No+Rc0sCCiJbIgqWbujFyUoy9mjUr@vger.kernel.org
X-Received: by 2002:a17:907:3e22:b0:c40:9839:c892 with SMTP id
 a640c23a62f3a-c4ca7a407b5mr929069066b.19.1793653432126; Mon, 02 Nov 2026
 13:03:52 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031095716.3030288-1-amir73il@gmail.com> <CAHk-=wiPhTLn1p0ZHx-7SMdk4_zazqDK1k7MMEn9scRfqeDgtw@mail.gmail.com>
 <CAOQ4uxjNrdxZdZZipsqnUNq+TswCKqp+30iKRKCqh2WOQ-zKGA@mail.gmail.com> <CAHk-=wikNxjCHDOSqEDanyNqfbVRRKXetGcLzFn2zUsbhUUexw@mail.gmail.com>
In-Reply-To: <CAHk-=wikNxjCHDOSqEDanyNqfbVRRKXetGcLzFn2zUsbhUUexw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 13:03:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi0qNR+ZLqAk49fW-dJcGKLxgEXQveZPKHoA88VnchpGQ@mail.gmail.com>
X-Gm-Features: AclHuK-VR3TscPvD0CVCydv-TmYZyiiJ3WqZgGmQCuzmzg-qkiRCQeVPGw89q6Q
Message-ID: <CAHk-=wi0qNR+ZLqAk49fW-dJcGKLxgEXQveZPKHoA88VnchpGQ@mail.gmail.com>
Subject: Re: Return failure from take_dentry_name_snapshot() (Was: [GIT PULL]
 overlayfs fixes for 7.3)
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, overlayfs <linux-unionfs@vger.kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/mixed; boundary="000000000000ac7e34065f517bf5"

--000000000000ac7e34065f517bf5
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 11:55, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think this attached patch is correct.

Bah. I think it *was* correct, but I hated the deep indentations and
wanted to add a few comments about the failure case.

So I rewrote it with a helper function, with he outer function doing
both the RCU read-side protection and the sequence number test:

  bool take_dentry_name_snapshot(struct name_snapshot *name, struct
dentry *dentry)
  {
        guard(rcu)();
        for (;;) {
                unsigned seq = read_seqcount_begin(&dentry->d_seq);
                bool retval = try_name_snapshot(name, dentry);
                if (!read_seqcount_retry(&dentry->d_seq, seq))
                        return retval;
                release_dentry_name_snapshot(name);
        }
  }

which makes it fairly straightforward (with the main subtlety just
being that try_name_snapshot() needs to set things up so that
release_dentry_name_snapshot() is ok to call even on failure, but that
was effectively true before too).

I have now looked at this code so much that I have semantic satiation
and it has lost all meaning.

Time to stop.

                   Linus

--000000000000ac7e34065f517bf5
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mvzqxbg00>
X-Attachment-Id: f_mvzqxbg00

IGZzL2RjYWNoZS5jICAgICAgICAgICAgfCA2NiArKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogZnMvb3ZlcmxheWZzL3N1cGVyLmMgICB8IDEwICsrKy0t
LS0tCiBpbmNsdWRlL2xpbnV4L2RjYWNoZS5oIHwgIDMgKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDMy
IGluc2VydGlvbnMoKyksIDQ3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2RjYWNoZS5j
IGIvZnMvZGNhY2hlLmMKaW5kZXggNDA5Zjg0MWUwNThlLi5iMmZhNWYwYTY4YzQgMTAwNjQ0Ci0t
LSBhL2ZzL2RjYWNoZS5jCisrKyBiL2ZzL2RjYWNoZS5jCkBAIC0zNTksNTggKzM1OSw0OCBAQCBz
dGF0aWMgaW5saW5lIGludCBkbmFtZV9leHRlcm5hbChjb25zdCBzdHJ1Y3QgZGVudHJ5ICpkZW50
cnkpCiAJcmV0dXJuIGRlbnRyeS0+ZF9uYW1lLm5hbWUgIT0gZGVudHJ5LT5kX3Nob3J0bmFtZS5z
dHJpbmc7CiB9CiAKLXN0YXRpYyBib29sIF9fdGFrZV9kZW50cnlfbmFtZV9zbmFwc2hvdChzdHJ1
Y3QgbmFtZV9zbmFwc2hvdCAqbmFtZSwKLQkJCQkJc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBib29s
IHJldHJ5KQorc3RhdGljIGJvb2wgdHJ5X25hbWVfc25hcHNob3Qoc3RydWN0IG5hbWVfc25hcHNo
b3QgKm5hbWUsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSkKIHsKLQl1bnNpZ25lZCBzZXE7Ci0JY29u
c3QgdW5zaWduZWQgY2hhciAqczsKKwljb25zdCB1bnNpZ25lZCBjaGFyICpzID0gUkVBRF9PTkNF
KGRlbnRyeS0+ZF9uYW1lLm5hbWUpOworCXN0cnVjdCBleHRlcm5hbF9uYW1lICpwOwogCi0JcmN1
X3JlYWRfbG9jaygpOwotcmV0cnk6Ci0Jc2VxID0gcmVhZF9zZXFjb3VudF9iZWdpbigmZGVudHJ5
LT5kX3NlcSk7Ci0JcyA9IFJFQURfT05DRShkZW50cnktPmRfbmFtZS5uYW1lKTsKIAluYW1lLT5u
YW1lLmhhc2hfbGVuID0gZGVudHJ5LT5kX25hbWUuaGFzaF9sZW47CiAJbmFtZS0+bmFtZS5uYW1l
ID0gbmFtZS0+aW5saW5lX25hbWUuc3RyaW5nOwogCWlmIChsaWtlbHkocyA9PSBkZW50cnktPmRf
c2hvcnRuYW1lLnN0cmluZykpIHsKIAkJbmFtZS0+aW5saW5lX25hbWUgPSBkZW50cnktPmRfc2hv
cnRuYW1lOwotCX0gZWxzZSB7Ci0JCXN0cnVjdCBleHRlcm5hbF9uYW1lICpwOwotCQlwID0gY29u
dGFpbmVyX29mKHMsIHN0cnVjdCBleHRlcm5hbF9uYW1lLCBuYW1lWzBdKTsKLQkJLy8gZ2V0IGEg
dmFsaWQgcmVmZXJlbmNlCi0JCWlmICh1bmxpa2VseSghYXRvbWljX2luY19ub3RfemVybygmcC0+
Y291bnQpKSkgewotCQkJaWYgKHJldHJ5KQotCQkJCWdvdG8gcmV0cnk7Ci0JCQlyY3VfcmVhZF91
bmxvY2soKTsKLQkJCXJldHVybiBmYWxzZTsKLQkJfQotCQluYW1lLT5uYW1lLm5hbWUgPSBzOwor
CQlyZXR1cm4gdHJ1ZTsKIAl9Ci0JaWYgKHJlYWRfc2VxY291bnRfcmV0cnkoJmRlbnRyeS0+ZF9z
ZXEsIHNlcSkpIHsKLQkJcmVsZWFzZV9kZW50cnlfbmFtZV9zbmFwc2hvdChuYW1lKTsKLQkJZ290
byByZXRyeTsKLQl9Ci0JcmN1X3JlYWRfdW5sb2NrKCk7CisKKwkvLyBUcnkgdG8gZ2V0IGEgdmFs
aWQgZXh0ZXJuYWwgcmVmZXJlbmNlCisJLy8KKwkvLyBJbiBjYXNlIHdlIGZhaWwgdG8gZ2V0IGEg
cmVmLCAnbmFtZS5uYW1lJyB3aWxsCisJLy8gcG9pbnQgdG8gdGhlIGlubGluZV9uYW1lLCB3aGlj
aCBsZWF2ZXMgdGhlIG5hbWUKKwkvLyBpbnZhbGlkLiBCdXQgcmVsZWFzZV9kZW50cnlfbmFtZV9z
bmFwc2hvdCgpIGNhbgorCS8vIGJlIGNhbGxlZCByZWdhcmRsZXNzLgorCXAgPSBjb250YWluZXJf
b2Yocywgc3RydWN0IGV4dGVybmFsX25hbWUsIG5hbWVbMF0pOworCWlmICh1bmxpa2VseSghYXRv
bWljX2luY19ub3RfemVybygmcC0+Y291bnQpKSkKKwkJcmV0dXJuIGZhbHNlOworCisJLy8gV2Ug
Z290IGEgcmVmIGFuZCB0aGUgbmFtZSBpcyBub3cgbmVlZHMgdG8gYmUKKwkvLyBmcmVlJ2QgcmVn
YXJkbGVzcyBvZiB3aGV0aGVyIHRoZSBzZXF1ZW5jZSBjb3VudAorCS8vIG1hdGNoZXMgb3Igbm90
CisJbmFtZS0+bmFtZS5uYW1lID0gczsKIAlyZXR1cm4gdHJ1ZTsKIH0KIAotdm9pZCB0YWtlX2Rl
bnRyeV9uYW1lX3NuYXBzaG90KHN0cnVjdCBuYW1lX3NuYXBzaG90ICpuYW1lLCBzdHJ1Y3QgZGVu
dHJ5ICpkZW50cnkpCitib29sIHRha2VfZGVudHJ5X25hbWVfc25hcHNob3Qoc3RydWN0IG5hbWVf
c25hcHNob3QgKm5hbWUsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSkKIHsKLQlfX3Rha2VfZGVudHJ5
X25hbWVfc25hcHNob3QobmFtZSwgZGVudHJ5LCB0cnVlKTsKKwlndWFyZChyY3UpKCk7CisJZm9y
ICg7OykgeworCQl1bnNpZ25lZCBzZXEgPSByZWFkX3NlcWNvdW50X2JlZ2luKCZkZW50cnktPmRf
c2VxKTsKKwkJYm9vbCByZXR2YWwgPSB0cnlfbmFtZV9zbmFwc2hvdChuYW1lLCBkZW50cnkpOwor
CQlpZiAoIXJlYWRfc2VxY291bnRfcmV0cnkoJmRlbnRyeS0+ZF9zZXEsIHNlcSkpCisJCQlyZXR1
cm4gcmV0dmFsOworCQlyZWxlYXNlX2RlbnRyeV9uYW1lX3NuYXBzaG90KG5hbWUpOworCX0KIH0K
IEVYUE9SVF9TWU1CT0wodGFrZV9kZW50cnlfbmFtZV9zbmFwc2hvdCk7CiAKLS8qCi0gKiBGb3Ig
YSBjYWxsZXIgdGhhdCBob2xkcyBubyByZWZlcmVuY2Ugb24gQGRlbnRyeSwgZS5nLiBpbiBSQ1Ug
d2Fsay4KLSAqIFRoZSBleHRlcm5hbCBuYW1lIG9mIGEgZGVhZCBkZW50cnkgaGFzIGEgemVybyBy
ZWZjb3VudCBmb3JldmVyLCBzbwotICogdGFrZV9kZW50cnlfbmFtZV9zbmFwc2hvdCgpIHdvdWxk
IHJldHJ5IHdpdGhvdXQgZW5kLiAgRmFpbCBpbnN0ZWFkLgotICovCi1ib29sIHRyeV90YWtlX2Rl
bnRyeV9uYW1lX3NuYXBzaG90KHN0cnVjdCBuYW1lX3NuYXBzaG90ICpuYW1lLAotCQkJCSAgIHN0
cnVjdCBkZW50cnkgKmRlbnRyeSkKLXsKLQlyZXR1cm4gX190YWtlX2RlbnRyeV9uYW1lX3NuYXBz
aG90KG5hbWUsIGRlbnRyeSwgZmFsc2UpOwotfQotRVhQT1JUX1NZTUJPTCh0cnlfdGFrZV9kZW50
cnlfbmFtZV9zbmFwc2hvdCk7Ci0KIHZvaWQgcmVsZWFzZV9kZW50cnlfbmFtZV9zbmFwc2hvdChz
dHJ1Y3QgbmFtZV9zbmFwc2hvdCAqbmFtZSkKIHsKIAlpZiAodW5saWtlbHkobmFtZS0+bmFtZS5u
YW1lICE9IG5hbWUtPmlubGluZV9uYW1lLnN0cmluZykpIHsKZGlmZiAtLWdpdCBhL2ZzL292ZXJs
YXlmcy9zdXBlci5jIGIvZnMvb3ZlcmxheWZzL3N1cGVyLmMKaW5kZXggMDg2OTVhOTlmNGY5Li5k
OTE3NGVhY2NjZTIgMTAwNjQ0Ci0tLSBhL2ZzL292ZXJsYXlmcy9zdXBlci5jCisrKyBiL2ZzL292
ZXJsYXlmcy9zdXBlci5jCkBAIC0xMDAsMTcgKzEwMCwxMyBAQCBzdGF0aWMgaW50IG92bF9yZXZh
bGlkYXRlX3JlYWwoc3RydWN0IGRlbnRyeSAqZCwgdW5zaWduZWQgaW50IGZsYWdzLCBib29sIHdl
YWspCiAJCQlkaXIgPSBkX2lub2RlX3JjdShwYXJlbnQpOwogCQkJaWYgKCFkaXIpCiAJCQkJcmV0
dXJuIC1FQ0hJTEQ7Ci0JCQkvKgotCQkJICogTm90aGluZyBwaW5zIGQgaW4gUkNVIHdhbGs6IGV2
aWN0aW9uIG9mIHRoZSBvdmVybGF5Ci0JCQkgKiBpbm9kZSBtYXkgZHJvcCB0aGUgbGFzdCByZWZl
cmVuY2UgYXQgYW55IHRpbWUuCi0JCQkgKi8KLQkJCWlmICghdHJ5X3Rha2VfZGVudHJ5X25hbWVf
c25hcHNob3QoJm4sIGQpKQotCQkJCXJldHVybiAtRUNISUxEOwogCQl9IGVsc2UgewogCQkJcGFy
ZW50ID0gZGdldF9wYXJlbnQoZCk7CiAJCQlkaXIgPSBkX2lub2RlKHBhcmVudCk7Ci0JCQl0YWtl
X2RlbnRyeV9uYW1lX3NuYXBzaG90KCZuLCBkKTsKIAkJfQorCQkvKiBJbiBSQ1Ugd2FsayB0aGUg
ZGVudHJ5IG5hbWUgbWF5IGdvIGF3YXkgYXQgYW55IHRpbWUgKi8KKwkJaWYgKCF0YWtlX2RlbnRy
eV9uYW1lX3NuYXBzaG90KCZuLCBkKSkKKwkJCXJldHVybiAtRUNISUxEOwogCQlyZXQgPSBkLT5k
X29wLT5kX3JldmFsaWRhdGUoZGlyLCAmbi5uYW1lLCBkLCBmbGFncyk7CiAJCXJlbGVhc2VfZGVu
dHJ5X25hbWVfc25hcHNob3QoJm4pOwogCQlpZiAoIShmbGFncyAmIExPT0tVUF9SQ1UpKQpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kY2FjaGUuaCBiL2luY2x1ZGUvbGludXgvZGNhY2hlLmgK
aW5kZXggODRiMGNmZTRlZDBlLi5hYWE0YmE3YTEyOTkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGlu
dXgvZGNhY2hlLmgKKysrIGIvaW5jbHVkZS9saW51eC9kY2FjaGUuaApAQCAtNjY0LDggKzY2NCw3
IEBAIHN0cnVjdCBuYW1lX3NuYXBzaG90IHsKIAlzdHJ1Y3QgcXN0ciBuYW1lOwogCXVuaW9uIHNo
b3J0bmFtZV9zdG9yZSBpbmxpbmVfbmFtZTsKIH07Ci12b2lkIHRha2VfZGVudHJ5X25hbWVfc25h
cHNob3Qoc3RydWN0IG5hbWVfc25hcHNob3QgKiwgc3RydWN0IGRlbnRyeSAqKTsKLWJvb2wgdHJ5
X3Rha2VfZGVudHJ5X25hbWVfc25hcHNob3Qoc3RydWN0IG5hbWVfc25hcHNob3QgKiwgc3RydWN0
IGRlbnRyeSAqKTsKK2Jvb2wgdGFrZV9kZW50cnlfbmFtZV9zbmFwc2hvdChzdHJ1Y3QgbmFtZV9z
bmFwc2hvdCAqLCBzdHJ1Y3QgZGVudHJ5ICopOwogdm9pZCByZWxlYXNlX2RlbnRyeV9uYW1lX3Nu
YXBzaG90KHN0cnVjdCBuYW1lX3NuYXBzaG90ICopOwogCiBzdGF0aWMgaW5saW5lIHN0cnVjdCBk
ZW50cnkgKmRfZmlyc3RfY2hpbGQoY29uc3Qgc3RydWN0IGRlbnRyeSAqZGVudHJ5KQo=
--000000000000ac7e34065f517bf5--
