Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793828890;
	b=dAP8y+D/O6sv4Dq8trY6+QPGm9cOaMP0TjtX5lDaIMzZFPTZr7Gu0nUwfPnyAn2e+THW
	 9WeAVABMAH0FDIjj7KPoxzWJriVbKKDcUDsYOKCINtoZvxRJHl/TsTCv7uxzNNvTJOoru
	 d7QXGMW6ER+YWGGkauqhVHERXebi+9hFWA/UvOV0gi4gI4gf2BSEnqrrkdrSWyIB5TpU9
	 aLQxYAWaGL7kF7b4E32f0KJ0c2AOBVoYxqa2dSqqYgli9w1/VqhVJSkLoDZYnz2ONuXpX
	 2UGjEf5C0XKr8l1lpephgjRYQH/1T/vUlN0z5cMQCpk73ybibcc6Ev/tejc7b1JGksA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=el0m2kbR9OlGIpwS5dnzF1QY7IXlBk1xl3IwxKlfbfw=;
	b=1BypbxPtDYoP7GCGbtEX86iGitHnsS7IBErBWo4XdwXeJ3Zbni8AgfB8P9/nLRmUsgZ9
	 J+5CV3awZpHzEflgQvtl0PYyvvP7TlwfAkzZtX4cbzdzpdPUcrEzSWIKBrLu7O9JhxRdZ
	 e+xZFcuCyvRQ7tFG1rjNRY6+PYoAydRLuNRxNCclbRDb9+LmhS0yNK8ZvmjpKijYX7dO8
	 FLzwCNFfOm+efB4C69jk0QUTRaAJViA65jcPl7YOiRWz9KmSZE1RrptjUhZ6CePd6SEEt
	 3m2d2Jo2oX4rwW5cruZGG6WOdhtnGnqC7W4FMCJMl8HGzeEf4w6Jmh1wWxtOV2xWi4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S5lMc6NN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E8607040A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 21:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A7E8607040A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S5lMc6NN
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so17565ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 13:48:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793828889; cv=none;
        d=google.com; s=arc-20260327;
        b=FIpxjUrwBLxk5AsSOojiMZ+RzPpwULYKrlq7FesAnqOcWHjlbSaTuI2Gs1I5+pg5Fo
         lV3UGdR9SsYVIVFdGhHLLe6SFU3bvQxaIX8+u1zBIV7a5p5bWYQvVu20m52MpOYvyuy0
         HEPOvkLrBVgMTdK8RKxsC4xO2qJKCNNXdm1pVYVhKPwsfQ1tz6ITdyeGOAzns6CIXQIv
         rqzL/86BMLvEwN7zEvZqdokHxXBVyIK//J1QovmGW4ECP0eAqwbYA1gh8QRJMKh1Q/kZ
         zMq4oObEeTylPo3tcKm4t/rchWM6YNkbEIhzQ7kBsGeAsBeqqUHNon/DFxcUXu6lkVFb
         kezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=el0m2kbR9OlGIpwS5dnzF1QY7IXlBk1xl3IwxKlfbfw=;
        fh=7mJUVuDvnfYWIVRqWfdluoKVGa5gmjySN/dGUDufUu4=;
        b=VEdvExd7hIOdUxCAFRvwrupKw0D8gvLD2HKHhVfhbmQKLe7tG9VhiweCHizK0eq4M/
         VbVjb4ciik7K2QLvsyMxbEOAm2lK63l1kU5wDIfh7O3EL0xD8p4nQEa/38K/pzOM4DFc
         iDEb8cOFmyHno6rAmtC6KnnZBx4mVnRwWUaEztJXK937lfCYWYPBba8AY42O3o2UEOC4
         hmJit/T+1ds/d31IssB/yQIl7CAvxLfoOlCut7jU8GZNomL4mEw07n9B8QFCK0QaDjl4
         QNbLjc0DCkh5NVeoD5sblmJM2jotzbmWYqgmyBiNY1qxrIswFAwBkYvz5u7MGpGsR8el
         G8gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793828889; x=1794433689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=el0m2kbR9OlGIpwS5dnzF1QY7IXlBk1xl3IwxKlfbfw=;
        b=S5lMc6NNivNoNxDEj9AwiKwlZ4PWjQOUEE8jptAqtha1iBEu01iBirIlhEPFG9eIGL
         p5c8ioPkDs6HgWRmvwq+QHDlVHid9rJPtuVNvsMaIeidmBiGSRk9SwWZN2yvMBSBgsjb
         rYvqyZ9krM7dgx4+SlTaS95G7DKiYbkFABvfRrWmTvUnrFpINbLtfdlBfXKwFEJlzpJe
         PT505kSwWUoHuLpN2bBfAkhB5FswMDpFoRXkyN0ze4JaCoAQ9gVg0gAfdtDzi8XiKYFW
         2pTi5Mu/2LdgKMEpc7FONIXhyyPva+sU9Ih5d2KkCzgIvKtNv6o/IuvGhzWNDE/zR8cu
         VxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793828889; x=1794433689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=el0m2kbR9OlGIpwS5dnzF1QY7IXlBk1xl3IwxKlfbfw=;
        b=pjB8eBlD/NvlZG7uv+hJHNFc8uKicuVK9YsGFL7Genmk4wPcmp3jBlZsx372rcrLgH
         5rrpERtTYGD8qN7CL8CaIHzPtvfm8EIsMm2/Qyn1W8HL+f5B4XXq+tDYj7MM6UVHVeMf
         723cCZ+rtA1mLTFfxU/M+9kTZE3TDEAG7Nxy9z67oZkeZMlIjJcbhqUqGUoJnr4uET8K
         4yQbxdsXZAQPJJ1oE3sKIzymTXIyVRwY0OqVb3Aa71edFIO+h/LBquHg57B/OZIC3CCr
         TXfq+w3sBR3F0XBUom0AYpWeClx/Sx0qkKeNLt3hZ1AUQn4pIQfsHMg1GruO0BmB6BW0
         5FFA==
X-Gm-Message-State: APuU4Z/Grqe4ZRYXZbRDI+db21wbPnKf2KVuCBeK671yXlKJpyYmUMkq
	RpYXylLVTrc9QoCh0sg/iIKCNQRivrUSc7v8CRkIx7M0x4wuCOzTgLIczirpu7aByY3JwpfU1ip
	41A7GeQoBn+Ibh13vl7UzdDzKEiTxQDKQ+LJo2aBu
X-Gm-Gg: AYBFou15F4wkVnvc/rsagYqB1X6e2dX9BGtKmDaq0KAIiSe0M247ZEd9ekuzAGljc1v
	w0zfduJZTDiPWtNSoghdH+7dZNWYDgi8ULYL85jllj6+sBz5ywW9Y3fDXDrUoyjO/jCFupGEWcj
	wRy4s1MLCagNqNZ5IQ1AVF1xg68ztFUSgT6dwyQza0KMnf+OhgiEW1JX2ct1luVNiczqjt9rLTk
	pBoQ0jIC3kcluQt5cuLpdGj2H1mcS/kSbByXxC5Re1n0hJpZ2AXiLL0IgmRZsUay/OodcwWdqw5
	vaBu/SEJPDKiOi5gE60a6I+RUTFwMBu4B1oog2EUiPJfZ3VjCS1dIKRV2sI+J4SZ3HXsH/Cn+Pg
	aoZm8jUtqgsduitPLv/Ti1SrqQEroxsgTBCNyQj1DCvQDi7tmM1o/WIzB2V1PC+U7xaMpdWE8hF
	Xsec8CyZgB9Rnf37jw0m2jSg==
X-Received: by 2002:a17:903:3d0f:b0:2c9:b404:b55 with SMTP id
 d9443c01a7336-2ed2627b4cdmr1246795ad.6.1793828888354; Wed, 04 Nov 2026
 13:48:08 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org> <20261030-work-procfs-ai-fixes-v1-3-772392d3ccfd@kernel.org>
In-Reply-To: <20261030-work-procfs-ai-fixes-v1-3-772392d3ccfd@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 4 Nov 2026 22:47:31 +0100
X-Gm-Features: AclHuK_M6vPw1MX2q5mdqF8qWU1tK-oDVzfL4yLTme8yjvHjkxfS7f-rX4lbKQc
Message-ID: <CAG48ez1EtkET27iMBY7tOm_anefqWaXmchFjuXtsfhimM67VhA@mail.gmail.com>
Subject: Re: [PATCH 3/7] proc: stop fdinfo files at a privileged execve()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 5:12=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> /proc/<pid>/fdinfo/<fd> checks PTRACE_MODE_READ in ->permission(), i.e.
> when it's opened. The file it describes is looked up in the task's file
> table on every read. So a file that was opened before the task executed
> a set-user-ID program keeps working afterwards:
>
>   observer, uid 1000              target, uid 1000
>   f =3D open("/proc/<pid>/fdinfo/5")
>                                   execve("/usr/bin/su")
>                                   fd 5 =3D open(something as root)
>   read(f)
>     pos, flags, mnt_id, ino and ->show_fdinfo() of su's file
>
> ->show_fdinfo() shows, among other things, the targets of an epoll
> instance, inotify and fanotify marks and the state of an io_uring.
>
> Use the exec id helpers and hold exec_update_lock until the file has
> been looked up. Reading a file that was opened before an execve() now
> fails with -EACCES if its opener has no access to the new program.
>
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Fixes: 2793274298c4 ("add file position info to proc")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>
