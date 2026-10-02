Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCAB39A806
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951558; cv=pass; b=o2Y7oiv/YB0d8l8nruSflWjPRv2B0Hvwel+iEeiYEdM9ilhDRGB/WGgOwOd5RUo/09BSCYYYU2b8As0jw2DjjiCdTh0X02EsfIk/8urL+JXKr0zTp5/EQf3aNDHCosy1YC6N3tmkGy/aJXFGB/J3bthn5cSb6ZiZQra6OtPyunA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951558; c=relaxed/simple;
	bh=TJqIX/4CQn1+ZlnzXl9wEuWSgH40s35Hxd87SbTH2T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvJGWktWtiRQ2AAAYoq/BUpM6IcSsDou2TOu2sowu8Y9+OeV0P4cKy+Arhyi+knmfDXE3rAIegeOT22C4HdP/oCCF2DevutxWMa4XH7yrvTSg7PhI2qqJXi7/9gyVY0EEo6JzhTUZGPiG5+mmmtgybukQSfk/ww0CBDxTYd3hnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tmei+IgL; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tmei+IgL"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d3b445a84fso54435ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2026 07:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790951557; cv=none;
        d=google.com; s=arc-20260327;
        b=HhThKiMnJeHYE1U876/TSmFwHBQuOCum4iZj/hSl5uWnInx8EUoTFFUaocag2ys5Ch
         +TrNXg0anDmo7SBI7mAT87wBBifa4V41H7y8LPKvhTlaPfvd2irCOIh1nwZSeR7uJRzJ
         S5JcyLP5/NPQxcXGXL/Z1kWd5qitk0OfVRbmYzXms2YqXVDUbMxpDzOpjGWf9TeakkSD
         rZkEUBgxSraUCnKUkeldtxRk0z7XuqzkgA+ZsDu/YQkNvDyPtCt8gTi+s2T4wyZsvcBE
         ueD+kQzYnOaGqzxmIMUfWEIl39kU8VNrjCrovd6niuYl5wi3yImTQiQf3IcEHgw0CMhX
         xIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=to8620MNaPtZOK070dv1Oxy/f9OGVvcG0m3sMTMM4xA=;
        fh=zMEr7HHY49IJpvtvmdd9eT3RJ+A/k7Vn1hngFb/QcQY=;
        b=DS0Hd9VR6ehUvnjRMlSVxGzKNx5ADnGgtO6044OToQkjO51CJfUwG9ArKK34MyR0EL
         alRC7x1snCZBFJ8fmj85+zwUELKYkoS99F3+lhPQfRq/6v9/OmeDYl1YV8W73C5QhMJ6
         JEEK4iLHYeFdSKAz94Th0ifqIyJMHcLFmW31s4gjdZOYi881ekoQ6cPXCEHqhPzps42G
         6kxt94MaQzbRkaLI3K1rmP/nU5UtiWOqXZxZQkgzrQwird3Ww3FThCKYB0KlCTFQlUu+
         W30uVI081hx/rJY2byfGpWuVxzbHXx9rwm3VSxD4+qjq2Fe8p7Cy7UwQ1bncqpy/vRYi
         7aHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790951557; x=1791556357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=to8620MNaPtZOK070dv1Oxy/f9OGVvcG0m3sMTMM4xA=;
        b=Tmei+IgL1R3U2W4aJN2pDoef4N+kXgre0DD+RB/fn9E5dg7SFlRRvkYhdzKR357GiN
         XspLj0ilpF1StCzBFGJCN3/rZAnfcLIrgE9o9cR4lO6IgB2od2HuaTqqvXq/KqOnemQs
         JqIkvcDvCaFLoFhbdZAMNFfsUU64w+ENTkZen7ovP/tCYZLx06PMCgNmoVAwNC7ZC0nB
         nqsEt1hGslpBcKp8QKYk/tZ3PshOPubVELsHill/vp1TDS5IDPTwHUYJ1jUYv2WrINOo
         aKie++cNaEd7GQu4s5LDj4P/n30Wq3V5uhnLWPTOzDkwKNTlBp8yEAzvJ2CQ9Lt9QKFg
         EEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951557; x=1791556357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=to8620MNaPtZOK070dv1Oxy/f9OGVvcG0m3sMTMM4xA=;
        b=h0vxcT1nGTeHMIA27aEP7JJgpR6jqsmQ/vEFVDMq6VO2wkyfJTiJfp1uwu9r+wHmxm
         8xG3kh092ruqOevnYOVGg5+nnK/Al6JB7Q8R4HH6wUBsxYkm2EsrNmDZGWdN3DJwUdvO
         uYuveSIwCjYzGsrEOTeJ2T1vQX1jyLe+KFR7bTHSMn3IYdvTAoSQb4GTWgKMCGkEFm2U
         gHu/YVUn0W0QwZvv/F1fmOiKcBdm/v5JchDNIOQVDHpe0+ssoupRQH59jEJVzFxjgYGF
         hNckt8fTX8+rJCia3hfmdlNz14pUlXY36RuFO7GyVw7sYKS3GKR9XnrgPVwqa9zzxKXT
         KxPg==
X-Gm-Message-State: AFq9FYIQ/Tdhkdde2ZNu7STXbInnabyO/BGPCpgeAXw7SCvH0sUpHqaJ
	jPr6cL7ShrnK4tYnIeGqRpfegWzauHAKWKF4JFzzOyWXKNgrME2kGLTcZocoKiyPeyr/D9Uluyl
	WrlYBTVeTIrbAbuAW4ePKTfu1jGRY0YzMF9XbatMt
X-Gm-Gg: AYBFou3u/bleieQep57VydEXloMJnYQNS9lolEuuqAI+pIdbDxqRR44Db7F1eJpBRSS
	UnAM607B8Ss2U2EG8E5PBGACg8wPLfEkfZWbW9/ojbPDkiiY0wUi9NTwv1xXsFZL+3TM52GiTp2
	oRLkNqattVLjiKvCJfaYKz33XqnfB0cN2ysu6g9GQmeNTwOGZdFWjeIfWPtYFihfl6mO7wYrIVj
	s0q+7ArRBY8B4sEsgX7Ap5OMEg3FzvWhA2Ayw3HFx9PS373EPapt7oM09coI+m83gZfy69HvoZs
	bPQTiExANrFCGbbKlwtgksSY5wYyiKR9LpPc6g7kE/ku+ilIgf84ahFZS2NQtIXkDIeS/GyUi1J
	EJGizY2hAoW8bi1StYo90OnfDLZt8NDmIw359e6JNJg==
X-Received: by 2002:a17:902:ce89:b0:2c9:bd54:cf with SMTP id
 d9443c01a7336-2e49b95d4a8mr3733365ad.4.1790951555834; Fri, 02 Oct 2026
 07:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002-work-mount-cover-v1-0-232a8f52b43c@kernel.org> <20261002-work-mount-cover-v1-1-232a8f52b43c@kernel.org>
In-Reply-To: <20261002-work-mount-cover-v1-1-232a8f52b43c@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 Oct 2026 16:31:58 +0200
X-Gm-Features: AclHuK-z1jphz9pVkfN_7LOXzoEJGyxYZ-XaZTSYiVfqZ5tJDbTZqNlHdMjcKY8
Message-ID: <CAG48ez3rU3W_93mHwzG8AedMs71Qb57reEbfkgVHj3i2UhKHog@mail.gmail.com>
Subject: Re: [PATCH 1/3] nullfs: add an empty immutable regular file
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 4:14=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> Add nullfs_new_file() to allocate an empty immutable regular file on a
> nullfs instance as a dentry of its own. It is never hashed under the
> root and so can't be found by lookup. Reads return nothing, changes are
> refused, file locks, leases and delegations are refused as.
[...]
> +/* a file of nullfs is permanently empty */
> +static ssize_t nullfs_file_read_iter(struct kiocb *iocb, struct iov_iter=
 *to)
> +{
> +       return 0;
> +}
> +
> +/* an empty regular file, with the same refusals as the directory */
> +static const struct file_operations nullfs_file_operations =3D {
> +       .llseek         =3D generic_file_llseek,
> +       .read_iter      =3D nullfs_file_read_iter,
> +       .fsync          =3D noop_fsync,
> +       .lock           =3D nullfs_nolock,
> +       .flock          =3D nullfs_nolock,
> +       .setlease       =3D nullfs_nolease,
> +};

If this is supposed to function as a sort of error sentinel, you could
also leave out the handlers for .llseek / .read_iter / .fsync. Maybe
even not set ->f_op at all so that it defaults to no_open_fops and
open() fails?
