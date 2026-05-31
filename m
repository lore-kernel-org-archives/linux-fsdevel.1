Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4217A49620
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 01:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780189936; cv=pass; b=SSGA+K3Iw9DgUDanSogMoUpxvpgsbFwn7duJc3KeZD1y8qWJU1GJ+0DCCh92Vkg0XbzQ1EX+RvSmtMF5dRoD+8XjePhX7WgNpQQJOW8/QCt7SWBbC4w0KiG+gAAvDgAF/81sLT306K+Tq5GRyewJTowZIwahJHKlp4BMjm1ItuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780189936; c=relaxed/simple;
	bh=W62O6qbs3ZKG8xO/+DyqjzyW9/JwB0GbWGE/e3oqbR8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=owcU1dtbmJgCKF/kbDUPAzGYjX+NrNjr4KtcvdUCBDbwucfZQyfLJ7SMgpQcHCvUnuo1LtHCEzdyP9lRPD4HqNeRI2+XJjLe1megbyT8nlbB+VYNKgbFHGPjrbbIpBjK5DaoprAZelQdP47gAlo+SCLWhI7c6vcwEz0tF2dCpp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpF2r3nf; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpF2r3nf"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso901721a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 18:12:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780189934; cv=none;
        d=google.com; s=arc-20240605;
        b=Zd04DrS/Tj8CCGDR8T8OAkeiw3T/tHJjL7h27hb5yNu5D0ABpp+A0cqsB1l1tyeq59
         J+yCeBAK616hrKUk9AlzzVi35lb0nhV0rBNN6A7YxdSO8AidLabY2Uwi13W2RJXlor6e
         e8Vg8vkuK1qx84KCWy4MNAkz6lomdKv+vVw6UWcsnSZg7QAEVgvgo4HgDtFYN1pNWnVc
         AZ0V+9mhDdCLzQOVNnTmpDiHvUfhdd9H+mAx1cwcKZXqeyJwEzAkKxhFOjZlRb9DDmnH
         UCojVRf6Y5TSs7pxo/sJZrqzkYUgU/cYYT6ihWbExXSa8MgB+2Rp6VyriWBD5AL+lT0Q
         wErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=K3IRqDu/cs1dVQ1QO9A0E2Hsj/Zj/URAXOHivWFZLc0=;
        fh=ykageJM+NGqHtKMBuMx5oSj4miJ66u+5aPhQ9keDlyI=;
        b=G7B0VEDE93kMwzWZS0X0R1guS2EGWzWnLCE7RWyz7IHbv6Ci/GufwCX2aPHhyZrCSq
         RFpPiQtCHgS68nflHJwxrF8EbggRb+AyfVccmMfmZVk5sbqp/RirtQtdq8BT8BJRCXQA
         E+ODkkxOqGSdazUpe1xfv1QUP8tJGJN8mLZFgDRpRXhHv8adcK7eK+olPadtwCytY9jv
         0IuvtrsdIyelii0cEKdUKlrYc+Dq24tJoij+O8Fx9c13rhkn/k6W7wCYvh5sBfOPVdTx
         DOmFUKs8Ug1mbPp/16vnbO61yoWEAaLzde5TXpHf1wEE4dqOP4UlaCL29EPPhU5XyslY
         a1Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780189934; x=1780794734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K3IRqDu/cs1dVQ1QO9A0E2Hsj/Zj/URAXOHivWFZLc0=;
        b=kpF2r3nfb3XwO0WcND1DL589X2LY/nd+lPmyEE8esEfn7K6N+7Bx553sf1yUA86Bgh
         5uK9t2I+Q0cu0uSgCMRsDNIItax/gh2RiTKoy8v7rtT1u52bmgaBfStCrSH08vHImsKz
         COqq0FqTtXjZ3HrHElWAudWwq1FZweAUMJ0C5e81aGlYeHZRYB50LIl74xRUDaK0/oET
         WVHoGz+WEpXG9elOY0zBsrdE5Ocz6d6Q4DnXXF0ioslSi90v86yenb8FSg0fD04m8Toy
         dEQ1kbMSntWcD/yym9yGVdaM7IgNcsAfYf+Y8tYHc4Jnw2aAmrZB5k0WwUCyDufBCeas
         sQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780189934; x=1780794734;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3IRqDu/cs1dVQ1QO9A0E2Hsj/Zj/URAXOHivWFZLc0=;
        b=JyemOVm6MvebmmMuC7jD0ron0Mv94iKF4Lwxhi4d77XWGOk0TeDQpy3zFet5RBAWRW
         PBDorN5ddx7672WdP/bVaXjB4FyJcb+X+0CO0f1y6LoSveetRdym8uHQyeGmEYreDAtr
         UPYEm34SnDIecwOvkIrcy05elf/+mutyj2030rrnag4tu3SMbOkFWnOy5O/mYM/+WWiI
         S9MGf3omtCZRNjgXrb586TAMk8S1cIGkYZ5ckpfgGx6VQbOnt0SEB9WPJvxUSjgrmhaz
         bJbubzwDrlu97FYm2rCS77xFS4Rodfw/cGPzb6ZlbK8afVYFCCwqOgpfiUvbhNnvut9T
         nwIw==
X-Gm-Message-State: AOJu0YxuHAMZZ93wDM96pmbDIXZ2K+dycIaHhB7W5h4//yW7F2QLF9XO
	iKUWYxumIV0hHRzTOTQHOAM/gYG1t3LAOFmpf9IRj3j8/lEN2NM64ED21DImShB0hlasnJoy9+f
	pPmqGPDaqMD2SZzWHIXYeX2Z0YqZAgGU=
X-Gm-Gg: Acq92OF2ovfvG/wahZ14i5lYNf+S0oSYwAV/bWuHy4D1fXQqv9ktYBhBAW0ffpQWnP1
	w7GtpvsPXIs4T/IPmpv0k60Df4ZtXIzJjxQrqtWoqz/Lt8lTUmhUqB4PA/QAyrOyTIEfspX2rDG
	KieMCN02c/9Hj4L3cgbH2SUvX1XtcNAE9wk1+F/ugVQa1iz2C2VCW72SOF/W0+d7SIDbXDfccCl
	amSv/c6CIqdqeFhcvSpYmC7Z9wvdPnDKkUvh9rkKiB0+HdWofuIrWIXGF8kKgzwWM3YPKtzs0Vq
	LbtANkTMgQmk/bVJh22fOEzO4nfC7AspGg68ypw7
X-Received: by 2002:a05:6a20:b08d:b0:3b1:8cf6:8f60 with SMTP id
 adf61e73a8af0-3b427f98183mr5887392637.12.1780189934435; Sat, 30 May 2026
 18:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0JDRgNGC0LXQvCDQm9Cw0LHQsNC30L7Qsg==?= <123321artyom@gmail.com>
Date: Sun, 31 May 2026 04:12:02 +0300
X-Gm-Features: AVHnY4KPEsdbKWeLNEnbmsMt_76NTAfc3Op-S-TznsaFqupDsP0IQ7F42VIWElY
Message-ID: <CAFbF8N7++zopZuEcsKRxBV_sgOGCbzCY0hOyMw1SiGAtuzGhyQ@mail.gmail.com>
Subject: PROBLEM: FUSE_NOTIFY_INVAL_ENTRY leaves stale negative dentry after c9ba789dad15
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: multipart/mixed; boundary="000000000000acdc2d065312c4c3"

--000000000000acdc2d065312c4c3
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a FUSE/VFS regression introduced by:

  c9ba789dad15ba65662bba17595c0aeaa0cfcf1c
  VFS: introduce start_creating_noperm() and start_removing_noperm()

After a FUSE filesystem returns a cached negative lookup for a name, then
later makes that name visible and sends FUSE_NOTIFY_INVAL_ENTRY for it,
readdir() can list the entry while stat()/open() on the same path still
returns ENOENT.

Bisect result:

  good: v6.17
  bad:  v6.19

  first bad commit:
    c9ba789dad15ba65662bba17595c0aeaa0cfcf1c
    VFS: introduce start_creating_noperm() and start_removing_noperm()

Adjacent commits:

  bd6ede8a06e89ca5a94a8b51cea792705d1b8ca2 GOOD
  c9ba789dad15ba65662bba17595c0aeaa0cfcf1c BAD

The bad commit changes fs/fuse/dir.c:fuse_reverse_inval_entry() to use
start_removing_noperm().

I attached a minimal libfuse3 reproducer. It does:

  1. lookup("config") returns ino=0 with non-zero entry_timeout, causing
     the kernel to cache a negative dentry.
  2. The filesystem makes "config" visible.
  3. It calls fuse_lowlevel_notify_inval_entry(root, "config").
  4. The test checks whether readdir lists "config" and stat("config")
     succeeds.

Build:

  cc -O2 -Wall -Wextra repro.c -o repro $(pkg-config --cflags --libs
fuse3) -lpthread

Run:

  mkdir -p mnt
  ./repro ./mnt

Observed results:

  Linux 6.17.0:
    notify_inval_entry rc=0
    listed=1 stat=OK
    GOOD
    exit code 0

  Linux 6.19.0:
    notify_inval_entry rc=-2
    listed=1 stat=No such file or directory
    BAD
    exit code 1

  Linux 7.1.0-rc5-00426-g670b77dfebe7:
    notify_inval_entry rc=-2
    listed=1 stat=No such file or directory
    BAD
    exit code 1

#regzbot introduced: c9ba789dad15ba65662bba17595c0aeaa0cfcf1c

Assisted-by: OpenCode:openai/gpt-5.5

Thanks,
Artem

--000000000000acdc2d065312c4c3
Content-Type: application/octet-stream; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mpt333dj0>
X-Attachment-Id: f_mpt333dj0

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKLy8gUmVwcm9kdWNlciBmb3IgYzli
YTc4OWRhZDE1OiBjYWNoZWQgbmVnYXRpdmUgRlVTRSBkZW50cnkgc3Vydml2ZXMKLy8gRlVTRV9O
T1RJRllfSU5WQUxfRU5UUlkuICBFeGl0OiAwPWdvb2QsIDE9YmFkLCAyPWVycm9yLgovLyBCdWls
ZDogY2MgLU8yIC1XYWxsIC1XZXh0cmEgcmVwcm8uYyAtbyByZXBybyAkKHBrZy1jb25maWcgLS1j
ZmxhZ3MgLS1saWJzIGZ1c2UzKSAtbHB0aHJlYWQKI2RlZmluZSBGVVNFX1VTRV9WRVJTSU9OIDM0
CiNpbmNsdWRlIDxkaXJlbnQuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxmdXNlX2xv
d2xldmVsLmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVk
ZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiNp
bmNsdWRlIDx1bmlzdGQuaD4KCmVudW0geyBST09UID0gMSwgQ09ORklHID0gMiB9OwpzdGF0aWMg
c3RydWN0IGZ1c2Vfc2Vzc2lvbiAqc2U7CnN0YXRpYyB2b2xhdGlsZSBpbnQgdmlzaWJsZTsKCnN0
YXRpYyB2b2lkIGF0dHIoc3RydWN0IHN0YXQgKnN0LCBmdXNlX2lub190IGlubykKewogIG1lbXNl
dChzdCwgMCwgc2l6ZW9mKCpzdCkpOwogIHN0LT5zdF9pbm8gPSBpbm87CiAgc3QtPnN0X21vZGUg
PSBTX0lGRElSIHwgMDc1NTsKICBzdC0+c3RfbmxpbmsgPSAyOwogIHN0LT5zdF91aWQgPSBnZXR1
aWQoKTsKICBzdC0+c3RfZ2lkID0gZ2V0Z2lkKCk7Cn0KCnN0YXRpYyB2b2lkIGVudHJ5KGZ1c2Vf
cmVxX3QgcmVxLCBmdXNlX2lub190IGlubywgZG91YmxlIHQpCnsKICBzdHJ1Y3QgZnVzZV9lbnRy
eV9wYXJhbSBlID0gey5pbm8gPSBpbm8sIC5nZW5lcmF0aW9uID0gMSwgLmVudHJ5X3RpbWVvdXQg
PSB0LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLmF0dHJfdGltZW91dCA9IHR9Owog
IGlmIChpbm8pCiAgICBhdHRyKCZlLmF0dHIsIGlubyk7CiAgZnVzZV9yZXBseV9lbnRyeShyZXEs
ICZlKTsKfQoKc3RhdGljIHZvaWQgbG9va3VwKGZ1c2VfcmVxX3QgcmVxLCBmdXNlX2lub190IHBh
cmVudCwgY29uc3QgY2hhciAqbmFtZSkKewogIGlmIChwYXJlbnQgIT0gUk9PVCkgewogICAgZnVz
ZV9yZXBseV9lcnIocmVxLCBFTk9FTlQpOwogICAgcmV0dXJuOwogIH0KICBpZiAoIXN0cmNtcChu
YW1lLCAiY29uZmlnIikpCiAgICByZXR1cm4gZW50cnkocmVxLCB2aXNpYmxlID8gQ09ORklHIDog
MCwgNjAwLjApOwogIGZ1c2VfcmVwbHlfZXJyKHJlcSwgRU5PRU5UKTsKfQoKc3RhdGljIHZvaWQg
Z2V0YXR0cihmdXNlX3JlcV90IHJlcSwgZnVzZV9pbm9fdCBpbm8sIHN0cnVjdCBmdXNlX2ZpbGVf
aW5mbyAqZmkpCnsKICAodm9pZClmaTsKICBpZiAoaW5vID09IFJPT1QgfHwgaW5vID09IENPTkZJ
RykgewogICAgc3RydWN0IHN0YXQgc3Q7CiAgICBhdHRyKCZzdCwgaW5vKTsKICAgIGZ1c2VfcmVw
bHlfYXR0cihyZXEsICZzdCwgNjAwLjApOwogICAgcmV0dXJuOwogIH0KICBmdXNlX3JlcGx5X2Vy
cihyZXEsIEVOT0VOVCk7Cn0KCnN0YXRpYyB2b2lkIGFkZChmdXNlX3JlcV90IHJlcSwgY2hhciAq
KnAsIHNpemVfdCAqc3osIGNvbnN0IGNoYXIgKm5hbWUsCiAgICAgICAgICAgICAgICBmdXNlX2lu
b190IGlubykKewogIHN0cnVjdCBzdGF0IHN0OwogIGF0dHIoJnN0LCBpbm8pOwogIHNpemVfdCBv
bGQgPSAqc3o7CiAgKnN6ICs9IGZ1c2VfYWRkX2RpcmVudHJ5KHJlcSwgTlVMTCwgMCwgbmFtZSwg
TlVMTCwgMCk7CiAgKnAgPSByZWFsbG9jKCpwLCAqc3opOwogIGZ1c2VfYWRkX2RpcmVudHJ5KHJl
cSwgKnAgKyBvbGQsICpzeiAtIG9sZCwgbmFtZSwgJnN0LCAqc3opOwp9CgpzdGF0aWMgdm9pZCBy
ZWFkZGlyX2NiKGZ1c2VfcmVxX3QgcmVxLCBmdXNlX2lub190IGlubywgc2l6ZV90IHNpemUsIG9m
Zl90IG9mZiwKICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZnVzZV9maWxlX2luZm8gKmZp
KQp7CiAgKHZvaWQpZmk7CiAgaWYgKGlubyAhPSBST09UKSB7CiAgICBmdXNlX3JlcGx5X2Vycihy
ZXEsIEVOT1RESVIpOwogICAgcmV0dXJuOwogIH0KICBjaGFyICpidWYgPSBOVUxMOwogIHNpemVf
dCBzeiA9IDA7CiAgYWRkKHJlcSwgJmJ1ZiwgJnN6LCAiLiIsIFJPT1QpOwogIGFkZChyZXEsICZi
dWYsICZzeiwgIi4uIiwgUk9PVCk7CiAgaWYgKHZpc2libGUpCiAgICBhZGQocmVxLCAmYnVmLCAm
c3osICJjb25maWciLCBDT05GSUcpOwogIGlmIChvZmYgPCAob2ZmX3Qpc3opCiAgICBmdXNlX3Jl
cGx5X2J1ZihyZXEsIGJ1ZiArIG9mZiwgc3ogLSBvZmYgPCBzaXplID8gc3ogLSBvZmYgOiBzaXpl
KTsKICBlbHNlCiAgICBmdXNlX3JlcGx5X2J1ZihyZXEsIE5VTEwsIDApOwogIGZyZWUoYnVmKTsK
fQoKc3RhdGljIHZvaWQgb3BlbmRpcl9jYihmdXNlX3JlcV90IHJlcSwgZnVzZV9pbm9fdCBpbm8s
CiAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGZ1c2VfZmlsZV9pbmZvICpmaSkKewogIGlu
byA9PSBST09UID8gZnVzZV9yZXBseV9vcGVuKHJlcSwgZmkpIDogZnVzZV9yZXBseV9lcnIocmVx
LCBFTk9URElSKTsKfQoKc3RhdGljIGNvbnN0IHN0cnVjdCBmdXNlX2xvd2xldmVsX29wcyBvcHMg
PSB7CiAgICAubG9va3VwID0gbG9va3VwLAogICAgLmdldGF0dHIgPSBnZXRhdHRyLAogICAgLm9w
ZW5kaXIgPSBvcGVuZGlyX2NiLAogICAgLnJlYWRkaXIgPSByZWFkZGlyX2NiLAp9OwoKc3RhdGlj
IHZvaWQgKmxvb3Aodm9pZCAqYXJnKSB7CiAgZnVzZV9zZXNzaW9uX2xvb3AoYXJnKTsKICByZXR1
cm4gTlVMTDsKfQoKc3RhdGljIGludCBsaXN0ZWQoY29uc3QgY2hhciAqbW50KQp7CiAgRElSICpk
ID0gb3BlbmRpcihtbnQpOwogIGlmICghZCkKICAgIHJldHVybiAwOwogIGludCBzZWVuID0gMDsK
ICBzdHJ1Y3QgZGlyZW50ICpkZTsKICB3aGlsZSAoKGRlID0gcmVhZGRpcihkKSkpCiAgICBzZWVu
IHw9ICFzdHJjbXAoZGUtPmRfbmFtZSwgImNvbmZpZyIpOwogIGNsb3NlZGlyKGQpOwogIHJldHVy
biBzZWVuOwp9CgpzdGF0aWMgaW50IHVzZXIoY29uc3QgY2hhciAqbW50KQp7CiAgY2hhciBjWzQw
OTZdOwogIHN0cnVjdCBzdGF0IHN0OwogIHNucHJpbnRmKGMsIHNpemVvZihjKSwgIiVzL2NvbmZp
ZyIsIG1udCk7CiAgaWYgKHN0YXQoYywgJnN0KSA9PSAwIHx8IGVycm5vICE9IEVOT0VOVCkKICAg
IHJldHVybiBmcHJpbnRmKHN0ZGVyciwgImV4cGVjdGVkIGluaXRpYWwgRU5PRU5UXG4iKSwgMjsK
ICBpZiAobGlzdGVkKG1udCkpCiAgICByZXR1cm4gZnByaW50ZihzdGRlcnIsICJjb25maWcgbGlz
dGVkIHRvbyBlYXJseVxuIiksIDI7CiAgdmlzaWJsZSA9IDE7CiAgaW50IHJjID0KICAgICAgZnVz
ZV9sb3dsZXZlbF9ub3RpZnlfaW52YWxfZW50cnkoc2UsIFJPT1QsICJjb25maWciLCBzdHJsZW4o
ImNvbmZpZyIpKTsKICBmcHJpbnRmKHN0ZGVyciwgIm5vdGlmeV9pbnZhbF9lbnRyeSByYz0lZFxu
IiwgcmMpOwogIHVzbGVlcCgxMDAwMDApOyAvLyBsZXQgbm90aWZ5IHJlYWNoIHRoZSBrZXJuZWwK
ICBlcnJubyA9IDA7CiAgaW50IHNlZW4gPSBsaXN0ZWQobW50KSwgb2sgPSAhc3RhdChjLCAmc3Qp
LCBlcnIgPSBlcnJubzsKICBmcHJpbnRmKHN0ZGVyciwgImxpc3RlZD0lZCBzdGF0PSVzXG4iLCBz
ZWVuLCBvayA/ICJPSyIgOiBzdHJlcnJvcihlcnIpKTsKICBpZiAoc2VlbiAmJiAhb2sgJiYgZXJy
ID09IEVOT0VOVCkKICAgIHJldHVybiBwdXRzKCJCQUQiKSwgMTsKICByZXR1cm4gcHV0cygiR09P
RCIpLCAwOwp9CgppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCnsKICBpZiAoYXJnYyAh
PSAyKQogICAgcmV0dXJuIGZwcmludGYoc3RkZXJyLCAidXNhZ2U6ICVzIDxtb3VudHBvaW50Plxu
IiwgYXJndlswXSksIDI7CiAgc3RydWN0IGZ1c2VfYXJncyBhcmdzID0gRlVTRV9BUkdTX0lOSVQo
MCwgTlVMTCk7CiAgZnVzZV9vcHRfYWRkX2FyZygmYXJncywgYXJndlswXSk7CiAgZnVzZV9vcHRf
YWRkX2FyZygmYXJncywgIi1vIik7CiAgZnVzZV9vcHRfYWRkX2FyZygmYXJncywgImF1dG9fdW5t
b3VudCxmc25hbWU9aW52YWxyZXBybyIpOwogIHNlID0gZnVzZV9zZXNzaW9uX25ldygmYXJncywg
Jm9wcywgc2l6ZW9mKG9wcyksIE5VTEwpOwogIGlmICghc2UgfHwgZnVzZV9zZXNzaW9uX21vdW50
KHNlLCBhcmd2WzFdKSkKICAgIHJldHVybiBwZXJyb3IoImZ1c2UgbW91bnQiKSwgMjsKICBwdGhy
ZWFkX3QgbHQ7CiAgcHRocmVhZF9jcmVhdGUoJmx0LCBOVUxMLCBsb29wLCBzZSk7CiAgaW50IHJl
dCA9IHVzZXIoYXJndlsxXSk7CiAgZnVzZV9zZXNzaW9uX2V4aXQoc2UpOwogIGZ1c2Vfc2Vzc2lv
bl91bm1vdW50KHNlKTsKICBwdGhyZWFkX2NhbmNlbChsdCk7CiAgcHRocmVhZF9qb2luKGx0LCBO
VUxMKTsKICBmdXNlX3Nlc3Npb25fZGVzdHJveShzZSk7CiAgcmV0dXJuIHJldDsKfQo=
--000000000000acdc2d065312c4c3--
