Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B2F49B21F;
	Wed,  2 Sep 2026 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354235; cv=none; b=M2O2aKp403731LOxYza8kk3jiZmz/1IvbRXA9i119twOM82t6xmSkhF/5Jypsi91MuVnuTPEuNtwFzUFfW2GVfVh7e5FBmHp8WDp8TybAz+JrEIUSt+sLgACPRvv49I2yPc4zZt23RdhwyMyG9sGC4l6QcDcHWvqMBmgVQKP2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354235; c=relaxed/simple;
	bh=KywRZ7u7+wKpsLZU80tvxRa+CLPFR3Qh1sZrmVT+4Jk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FrajTBvtqqJzTNazChPA+c1rynzG7E7ZJzO7r9lCo7nT/AdDTOR6wq4XdSduv8dFp4hFfzPfeR2E2j1Wv2aFdBH52m9IVNq1aaJDEwcnZJQcBm4Tr8ozrH3JMbMTCac+RZec3svNWuQDZnWLh+4GMWF8nEdQEyYk9j9+txvXxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAizg2gQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAizg2gQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814311F00A3A;
	Wed,  2 Sep 2026 13:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788354233;
	bh=MTGGl3RwcuCFV/bUtDz32VMfXUuvDipc4YWXpSVJ+U4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VAizg2gQ6bti2K/G5cmEO/yrnvCZnBCqK75puimyI5sciyVcwGmhGAV+sXItvo6wB
	 akEeMM1nJxts2Z20NVdA8Mh4jFz19abshLk+e1sDxl5MsxdyuUxVSN+3peCN5Kv3Uv
	 218RfiUgmpHR8kUg2qqrdZ7TBx2oHxwzDM3xB0TeIj8FQGiTvxO6MMcMyLdwGMFj1W
	 iIw4T/zPnp1G8ln3EeoOhjdphhUUOHpxczReRMe7nM+kfgVDqt5xXw+BbaRtoBGX2d
	 sxYrcUHquzgZTFkM1xln4InV01fTUxjsdeo5wVYc/GkvLORSiATUZgreHwx1iqBKRW
	 jHE37ioqgc/3w==
Message-ID: <ab253791f92c329865168c4734c9bfe2f8537a5e.camel@kernel.org>
Subject: Re: [PATCH v2] fs/locks: filter OFD locks from /proc/locks for
 foreign pid namespaces
From: Jeff Layton <jlayton@kernel.org>
To: Tao Cui <cui.tao@linux.dev>, linux-fsdevel@vger.kernel.org,
 cel@kernel.org
Cc: alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, avagin@openvz.org, khorenko@virtuozzo.com, 
	bcodding@redhat.com, Tao Cui <cuitao@kylinos.cn>
Date: Wed, 02 Sep 2026 09:03:50 -0400
In-Reply-To: <20260902125139.975253-1-cui.tao@linux.dev>
References: <20260902125139.975253-1-cui.tao@linux.dev>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-02 at 20:51 +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
>=20
> Since Linux 4.9, /proc/locks only shows locks whose owning process is
> visible in the reader's pid namespace.  The check cannot see the
> owner of an OFD lock, though: locks_translate_pid() always returns
> -1 for FL_OFDLCK, so an OFD lock held outside of that namespace
> bypasses the filter and is shown with its device/inode numbers and
> byte range, e.g.
>=20
>     4: OFDLCK ADVISORY  WRITE -1 fd:00:70536961 0 EOF
>=20
> This was observed on a Kubernetes node: a pod reading /proc/locks
> listed the OFD write lock of an unrelated host process, while the
> POSIX locks of the very same process were correctly hidden.  The
> device/inode pair identifies which host file is locked, the byte
> range discloses where it is actively written, and the
> appearance/disappearance of entries reflects host task activity,
> contrary to the documented per-pidns visibility of /proc/locks
> (proc_locks(5)).
>=20
> OFD locks record the owner tgid in flc_pid, so use it for the
> visibility decision in locks_show(), mirroring what
> locks_translate_pid() does for POSIX locks.  The pid column is still
> reported as -1 for OFD locks; only the filter decision changes.
> Remote locks keep their negative flc_pid and stay visible as before.
>=20
> Verified with an OFD and a POSIX write lock held in the initial pid
> namespace while a process in a fresh pid namespace reads /proc/locks:
> the OFD entry is visible without this patch and hidden with it, the
> POSIX entry is hidden in both cases.
>=20
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>=20
> ---
>=20
> Changes since v1: keep remote OFD locks (negative flc_pid) visible in
> non-initial pid namespaces, as locks_translate_pid() does for remote
> POSIX locks.
> ---
>  fs/locks.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 6e4ff7fcec05..4af1385682e4 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -3022,6 +3022,25 @@ static int locks_show(struct seq_file *f, void *v)
> =20
>  	cur =3D hlist_entry(v, struct file_lock_core, flc_link);
> =20
> +	/*
> +	 * OFD locks are reported with pid -1, so the filter below cannot see
> +	 * their owner; flc_pid holds the owner tgid, so filter on it.
> +	 * Remote locks keep a negative flc_pid and stay visible as before.
> +	 */
> +	if ((cur->flc_flags & FL_OFDLCK) && cur->flc_pid > 0 &&
> +	    proc_pidns !=3D &init_pid_ns) {
> +		struct pid *pid;
> +		bool visible =3D false;
> +
> +		rcu_read_lock();
> +		pid =3D find_pid_ns(cur->flc_pid, &init_pid_ns);
> +		if (pid)
> +			visible =3D pid_nr_ns(pid, proc_pidns) !=3D 0;
> +		rcu_read_unlock();
> +		if (!visible)
> +			return 0;
> +	}
> +
>  	if (locks_translate_pid(cur, proc_pidns) =3D=3D 0)
>  		return 0;
> =20

First: I think this may be the wrong place to do this. Why not fold
this change into locks_translate_pid()? It seems like we'd have
inconsistent results wrt lock visibility between /proc/locks and
F_GETLK if you do this here.

Thinking about this some more though, I wonder if trying to hide these
locks is the right thing to do. These locks do exist and they do block
you from acquiring a lock. If you go to look at /proc/locks and don't
see them, that seems confusing.

Would we be better off showing all the locks and reporting the pid as a
negative value for ones acquired in foreign namespaces, like we do for
remote locks?
--=20
Jeff Layton <jlayton@kernel.org>
