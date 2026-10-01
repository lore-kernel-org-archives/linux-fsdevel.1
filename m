Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C13428CF4A
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790828387; cv=pass; b=n3kFb/FXgJeYpC263TjEkc8WrfZ2luacwqTgJCVCo+bwiojqNNujKK/j5HTWY+vuIvrtMm7bjoIOGFCAkJQxDlzs9yJOUmTTy3QSmwDyyJF2OaCZlW659SFUoJYx3FbAdr0rO5zOWXXKqLx09XAb3ZNt7OiSnM8/x/JhvePiXPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790828387; c=relaxed/simple;
	bh=NlwyKjfoR7VaJB7r+rozJPFGwYih64AWsVmx8RjDE44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc3tx+9htd7ZG90pL5uZ5r0czOS63z+FJjhqylbs5oWK/l7aqaXB4M6QT2j2/He7rQfJAvB1HGmyrV8syCJ/xvbjwcBgGSLAhHK02083pplNizd7mDe+XAJoRg2m+BVj113tIg4j0LlpuZSkZoYBF4C2GcGTkXF9eSgBZaTUYiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nosstv6I; arc=pass smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nosstv6I"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d07so5343219c88.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 21:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790828385; cv=none;
        d=google.com; s=arc-20260327;
        b=V1wFw34QwT+jWBhSm+XxVpAmRU7g2jcWrwMHD+iHhfcJ3tTpd0O6776YhdJ6kuLrdj
         r5vVKtXjNJIqs9NMsbZX2nvHl4ijjHThfbZb1e3SSnF+5Q6gK3fjsFdP39bDpOH/KIYj
         NNWPEFdFwISAZK0KxuKJPdYtKszos48Vo1L0jq40CENXSXLMrb0++95yRbf2gk/YBx3V
         uN1/bre4JKcd2rvBRw3hCGgebFuUGkhJG6AF2TCeLU91gXS2uafeNEmsMd2XilowmQX7
         DuHo+Ht3QIgK9a2K03UvPbFoshhNWt4sU8I7Qg4JLP2CSccFCgvZPPUb4B2ZXcJlTJ2W
         XgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NlwyKjfoR7VaJB7r+rozJPFGwYih64AWsVmx8RjDE44=;
        fh=krw/QfW+vMD0focLArRfDXhwRZhOWosjkl6cOl4yL1o=;
        b=DFKjH/zC4n2ghCR3VFCUwfGt2cCJXU3oad2c7l+L6+bnBZcrlUtaE5qnuOaOQMjRfT
         HDKSFTPwHcM4lJP8Hp3C+ka7wl6H5NebNqhGNqbtteLbF5L7JztWbjp2Xz6JaERUjMLN
         C7HcPJm8SvRW+9a9RmItVS4r1O9wJ5UwG5GiIPFneJKX6qDSCX1wyDokbgoMhK/97kB5
         ENLJ+hRco7SKo7IRBBQUQ5GM0sSVWMwszA5pju215j77NaYrv9AS/ZSJyFTN9O2jmaT7
         0mmaWns65kxzjg8BJGvU1H3f94KdjpJGPOEf8EN58Hv2LpgKFQJ4kJ6W2Mqt1Z2MVgwY
         nYag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790828385; x=1791433185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NlwyKjfoR7VaJB7r+rozJPFGwYih64AWsVmx8RjDE44=;
        b=Nosstv6IC2Cx2DPWSXy3kFMcJ0YGWTOTGNANPlu7ZTtISnj2FzwVrvM+0nicYypziu
         eLcbvTG2EuFXNi3HQzC3XORitoJxTF4QO4RU8VM6pB75tQwPRehBxRJhacu3+NHBd7xL
         Dz8OzmnVWiq+/B6vDO1Ub8Z6UDwkVegCHvEuNxP2CuskbiR0QI4sDrXSuo5vTepyKvG6
         aj86sqI3VsJ9ocYjpQ1voGVdH1N8gGP47OrtLqesvAzHuXbQroPPwm3lk6bbzc26EhtY
         TjTB4EnzK1keHYuprM8xODc3RF645oxTn7oKKMw0rrvjKLxEvy+k2EMUhiueGw8DPZmK
         YNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790828385; x=1791433185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NlwyKjfoR7VaJB7r+rozJPFGwYih64AWsVmx8RjDE44=;
        b=wyJxPUP5e6Seggi7axC4zDHV6snizZqiq0MIvmolljv4RPWCPpi303WDk/7VX9Gcrn
         /gS71IG0QtELX/c9/2sJ2Jth/x00To4s2umKqRm+Tv7UbagtQYaEY+Ru9mOwPPICTsLw
         YtHoxNt/EVOb3DfyfyX/OhGQx+L+MU4ArYoJXDwKhg1xcwNsSoQZOlOWngK2xBouyK6K
         +qKuhv6CnJ6QsJEi1KvfAvnK48+cMH1oz4cwcVhUE7ntju32O9o5yFfSgZXH+Ig+Baf7
         Xt/vTi0gl0oVBFDHgwTc9uxGKdJ0ey0NqiCVdV64DuWGILXIghW0v4YHUlaNWcnERfYW
         6fug==
X-Forwarded-Encrypted: i=1; AKwUvByxE21Ww11yteMgxaS3pj7Vroxb7Vz1bV7yaxlhMhEM3LhTOcbTO+3hHXsHn9krk6ocoIMIw/tSMElBX+AG@vger.kernel.org
X-Gm-Message-State: AFuF++lY9PJVDeiUWRphmBMZRFwkk6EVy8Kbf2C2Wza5CDmhWznaPY2J
	DPbGxRMQvSLVaYJipGbzeB7ZD2/a/rVYmNHTAWlzh+4NPSk8KZRDuJGJQ6gO73H6aczFARXPS3k
	B/SPIcK463Q+F/ZAtj7BjgXwOn61AXg6sggPGxVy6
X-Gm-Gg: AYBFou2yVFI2Hgel2e/KHBTVjX2Fa3cxIarxclSW+3bOVG26Y3Qi43oeWxzS5Pad13w
	DIXQwh2YVy9Jj6qrIpd1vKxl3G1+0VAFFdfVYWV8EOiZ5ASb/7K7AyTkiH0eg8rjfokAir1Pyhh
	USNteqiqqSIh2EVkrohVstHNP1Sg3sin8zxSvq9rmDGGWWpS8lIzXcMCg5ANuDxpsMQmpl4kEEv
	b8T60QR6v7PZY6KgLOqv4GG5abmfJoiFwZOlmgt4/Sa7IKOjy88xO6ivaCph7Sg9tFHQ6sXQ2Dt
	9FHaKoQAQlmj1rgX35g5VXSc/PLYAxxUoD8RMIuGnuxOaue15+AOlHuQ4XzxgarsRK0vMfG11mm
	vr0r0OslwWuN5f8w0GzzvtCXjH+do7D5YQnJzyZp1RVpWccJimNGbUTcC2uW2hWGEbsI=
X-Received: by 2002:a05:701b:2406:b0:149:1feb:6da4 with SMTP id
 a92af1059eb24-14d332a2be7mr3924860c88.32.1790828383999; Wed, 30 Sep 2026
 21:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com> <20260928-work-unix-passpidfd-v3-5-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-5-532018a91b21@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 30 Sep 2026 21:19:32 -0700
X-Gm-Features: AclHuK9j8Y3QqvxsWyBt02R9nnTt-bXIq_uC7eCGDMAC8dhm7oM4Sg6AFvi_bSE
Message-ID: <CAAVpQUD69=MBzg7QcE_9rhzjm=QO_Jp=WU+z=ihFYGPoawrR+w@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] net: turn sk_peer_pid into an array indexed by
 pid type
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:27=E2=80=AFAM Andrew Halaney <andrew@amutable.com=
> wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> Currently only the struct pid of the thread-group leader is recorded
> for a socket's peer. To make room for the struct pid of the thread that
> called connect(), listen() or socketpair() turn sk_peer_pid into an
> array indexed by pid type. All users, including bluetooth and the
> coredump socket, keep using the PIDTYPE_TGID slot.
>
> Nothing fills the PIDTYPE_PID slot yet. No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Technically, sk_peer_pid/lock do not need to be in struct sock and
can avoid bloating it just for a single user, but I can follow up on it.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
