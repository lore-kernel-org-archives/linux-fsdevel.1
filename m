Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793828909;
	b=b+xvtZkrfQrwjSX1RyJdXKU5h/z0aVEXAlfQne2kPgvwsz8i95iwkvwIxgdeBr+aT4iD
	 X84eyg6SKSwih7TwXmFD9bGKz8lNjjroHevV/zp9OdDVTbW5yl3rnew9wDmik83/2pdhx
	 XY8JsBqFPd1vMmsyekmZ2ZEApTV3qbWrYTZwgUxAFW9SvI6oB5Xy+/BMo/y7igMza1F57
	 84xvFN3OFbnQfD3CxBVz/uIkGoFpj+X6xrHrQE6IrdIY2iU6PyD/LzXoNxvxieTgszYva
	 NDABBtjqiHXFKuthSoyA+jCwbN8RLrmNazfcH6J2jAKdtJ1fZxEhPY8/6xa2m29MA6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2D2vDw/U+kzKAtYkN0TR4+tnXX0GaB+Xt7fUx5vEdV8=;
	b=3G2/kbDevmmIh1arzyZCo9esYVH+WvxUJWzw7oVnM7DYQZwU/MNdNb5UEpQirv6qoj8z
	 qVvgtegwSIHsvFJV2AjEMtuv3R428jx0qxgFyKqVFyf+/dhKlBGbS4AV+W3zf872dLioQ
	 pZFPCJruSAnqzMZ1hPcGPnDFSoXqqtnP4UHD92qJYA9j1e/o/UlxMEKn/lk0arOGwRCk3
	 JYilamUCxEDTtwh4nuPzEv2NztkKR4Wrl4rH3+/lRKHTjiLYKEmvMWTG5Fkmrmzx3Jb4Q
	 bqaGDSUokoz3zMUzN/+RA4Blz8OPj28uYPzsqIm754TwQeIB5jsDbMcSIEe0/+exBJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d+G92hXm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8FC6072641
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 21:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E8FC6072641
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d+G92hXm
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so7745ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 13:48:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793828909; cv=none;
        d=google.com; s=arc-20260327;
        b=HOrOdkQh9B/oPztMmDV17Kwud5cjWwI5zUhGv5MpS7fXPgtSNY8C9GrkiDfqDqEXC+
         kqwhxy6kU+XnW5O4vQSgX+M+vCFNjHp7CIN1q3jDnUvYw3uP2NZM+S8ArrS6sWRYTyLK
         qZNA2QgzzpeA2liRC8FXIZaTNDOtAIGeygTLFLb0todGU8O80KYc8eAylq74i8O5qNxg
         A68tLti2+HnowCG8GsqcIudAGdn+uOCOPMKo4RD7Z5rYCwxafhsKz8TXirf0xcsXus4O
         hWXvQVAn8AjcwsKwt2TpqrrUpq23VQifMyNpXAP6iII2Wgr63N6uTGnqEQrJ+unWe5Tq
         aRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2D2vDw/U+kzKAtYkN0TR4+tnXX0GaB+Xt7fUx5vEdV8=;
        fh=7mJUVuDvnfYWIVRqWfdluoKVGa5gmjySN/dGUDufUu4=;
        b=hEPAxOZ1qjcgO4p2mtOth8rMCzw4P1hNbi+OBd+x4jIbA6f+qQ+WhwkW1HLaPBxB9L
         d1Z0cuZPdwkUxGmQVxWtIgE3Tn2irF9lRMDgketk2w0zggMRYKmKMz3b2Iy+GHtpZJKp
         M2c6l6XcEZxIDtPTbtYBQDP8MzS6A09Mncvh3xcTnFvXsKphZpd+x3mnO/MVP6FfEnpN
         3wRXqfIo6N1JSlgPr54Rq5TSzCDa5zY92o4SxUXFJPXfxgoFF1mq6mQ4x9G5a2ra4MMm
         YXU4EufnN4fzVn2lpkAbkgYks8vazza2NlFaTW9qVshc9u4ONCbt5naAdEyzHDfjSyVs
         +8QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793828909; x=1794433709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2D2vDw/U+kzKAtYkN0TR4+tnXX0GaB+Xt7fUx5vEdV8=;
        b=d+G92hXmxS77rfXuq91ghXZziyKtZEkwEu2HNHDyofBsQgvIVj1DIcOYwRXAab3kg5
         w9Z344QyCiIOZf5Jv088EwOulHCW/Oh5T7Xb0jfL1hl5e1VnB1Yi/gUpFz/eYCYGN41r
         cQpKLgIO1Rt0N8zuRzPmLUX4oxROcZf9HaWBhYZwKhe74QRPVgoDGCKwD+HelWrz0riy
         ywxl8nDaI9ZSzSoRLdcXDU81ZoXoTziN2nBkqeqAnEwZ0HOsXserSFX//arfNY2xejdU
         hDjGA0Ocg8ps4i6APulhcuaCZ/sUUMWa0fqV0lf+1NSqQTN7wpZ5xUcATDFJteXDS/Hd
         mLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793828909; x=1794433709;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2D2vDw/U+kzKAtYkN0TR4+tnXX0GaB+Xt7fUx5vEdV8=;
        b=Gmx8iyxEdUUBiYQXYs9gjL8F0ZFZX7qh53oTZQ9w/BxijWZnDGiyHY3w8HBYPr6/H8
         24w93kzkBRuCTpA0F6ai+fanOLAGBVKMpkD61FGmT+M3XuJrbCByq/TgGhE98XvLjvAM
         2Aw5KHHw3MtarzNVMEm8kU9o0S8ooekHehToKJ3z4T2k6cDgiejzqFoSBtl/980Fg6ND
         zR8w2Pt+LRTupNPHItofpWd4K5Wn21jPbC8zl5LHGQIcUtG8wGeFfb0VGMXrQsGHlw4/
         FSfjOcIb04NhBh20A+eFQIqXmFomVAJ1oMUFCyCVIbQf6K5+A+JrWSP+zlEU5NQLPMQS
         C7ig==
X-Gm-Message-State: APuU4Z8vn54Zb9VppTi17qQ5medjfzdKfTqWxQHulwd/5WTdOWVFQCHx
	2lgh+n0+Bzs5st6GYhLnD6o2QwqUUMhGMBj3mtvST9QyzWdO4YF4IlRUr53MnBbsoiZ9DUZLdWU
	/xSnzJmQm/SaXYPV61mWouqdWfqIkYPw3+oBzmuRK
X-Gm-Gg: AYBFou1raZZoxa7s5IEyhbDl13NYHjj6m0hGdU+19crWv5gWPynkglqm9KkeNgJriCo
	xkKrSzUBeyVd018sOfgW3MkgXHpqd7p0XL9w3EhcU+Zo4zIFFX9HUUkoZ6ighFkc3XNVIGtGGJR
	Knsco97Tn/LBxFI3kVpj1JuOe+yaaVatxCa+TrkjPGZGkK4PfBMd7glVpX4H7SICTYFoE4u1CAX
	zULkJ2VZvOTbdJxkMbyc4A5AtgtkzZY3LiEzzd4p4MZgGtMg1jn1PO22yHWDkAUKA9oJrJgHfq+
	YrzdTK2r4GXgd1a7/y5D1wpCRVeInmN60eWtuNdsEwnkjoAaQCYbzDa6iNxo6odyVPQcuzRYoEs
	J1adqapiUyZdxNDDAV2owIEa1k6UEp2BHt1ud1Ep+yyfcuBsa3/oGSn37843LQrCZeNUBWY7q4T
	T2w9bz18V2hISthA/gQPeMIm+F0UA7hCOeylHdai5aElw=
X-Received: by 2002:a17:902:f603:b0:2e7:e742:8bb5 with SMTP id
 d9443c01a7336-2ed27e1d379mr577315ad.14.1793828908143; Wed, 04 Nov 2026
 13:48:28 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org> <20261030-work-procfs-ai-fixes-v1-6-772392d3ccfd@kernel.org>
In-Reply-To: <20261030-work-procfs-ai-fixes-v1-6-772392d3ccfd@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 4 Nov 2026 22:47:50 +0100
X-Gm-Features: AclHuK-H3qmqNMwpOu6RMabCmLAdKKvUbz4EbuzzaOSh5N8lY-B0Ollc90SywNg
Message-ID: <CAG48ez2UVYi98wAFUrrLKvPtU2QG=aocJRshshisUBYA_T_LHg@mail.gmail.com>
Subject: Re: [PATCH 6/7] proc: refresh the owner of fd/ before checking access
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 5:12=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> /proc/<pid>/fd and /proc/<pid>/map_files are mode 0500 and belong to the
> user the task runs as, or to root if the task isn't dumpable. The owner
> is stored in the inode and only brought up to date by pid_revalidate(),
> i.e. when somebody looks the directory up by name. A lookup that starts
> at a descriptor for the directory checks MAY_EXEC against whatever the
> inode says:
>
>   observer, uid 1000              target, uid 1000
>   d =3D open("/proc/<pid>/fd", O_PATH)
>                                   execve("/usr/bin/su")
>                                   opens its files
>   fstatat(d, "5", AT_SYMLINK_NOFOLLOW)
>     fd/ still belongs to uid 1000
>     succeeds if su has descriptor 5 open,
>     st_mode tells how it was opened
>
> That works until somebody walks through /proc/<pid>/fd by name. The
> links themselves are checked on their own, so what is behind the numbers
> isn't at risk.
>
> Refresh the owner in proc_fd_permission() under RCU, the way
> pid_revalidate() does it. Let the task itself in first, there's nothing
> to refresh for that and /proc/self/fd is what nearly all lookups are
> about.
>
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>
