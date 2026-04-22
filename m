Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1BC33987F
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776895651; cv=none; b=L4ZkfaHjEO0/wsQsC6ywnP+rNFhcaL0dl7rf87ewJEwEdSgVCRXfvXQ5BPyKcO/0IrdMXw7j0PUOnRcEEUiD+rE6u0MS4RsW0zgVH7+HqmUf3CDOxyRKDzPqJnle3QQlvt7kxwDIdgw/dwbFhAyXfGtswz1a0DNZfENTw35h9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776895651; c=relaxed/simple;
	bh=4TSkVAJjjyM9ISbLFQfw86fi2FjO68aikvO2+REFTqk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DuyzFq8c5gjDxleJUGwX10NE/x62daQwGuR9YfIr0LVTHTKwfFEjWdLkDc/QNlwi+/TPUyxofZXarpev+Bai0Fj4jWxyLYR/wz7COjNxFiGI+wlH1nI/GLJJALgyNzGb3DkNjp3Rj/4Hako+A+Z/NRt1jNbSSfohAUT/b4jG7d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=BLixY+f1; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="BLixY+f1"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c76b994f7a8so2292455a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1776895648; x=1777500448; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pi1PQxzv6t+FEuujchxKSF/WsBrOmGD99e4mBVfdVLM=;
        b=BLixY+f1NmJ+4X7to4oLvOrbR5KdZZ/FbtoNQD93amNOnhgCYEzbjxsNwxBZs9Z8y0
         wyyQr0BIMghK1mYUTgAJzszitlOlOPN3fsaA3VMxXCnR+tHAhp2j9IsCb8yZ6aFiKqlc
         WhCsGb4AC0LnwB0NTnUfnJhmBTtU1e3CD0SOkqkcW7JeiE1oShCMoTC3Pmu2hD+h6t2O
         zN344aQbRqvvcReAvxY6eyd9bntnMhU1BNBZxAazYfceCcTvF5zrVIKnq+hapiIhFBXj
         jbpJQibYST6pE1C4eqZXf4x4aJ6ZgZ23R0fqKqZD8AIgdJSlo90H6qUTyGxTzzk5eUrv
         gVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776895648; x=1777500448;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pi1PQxzv6t+FEuujchxKSF/WsBrOmGD99e4mBVfdVLM=;
        b=o4pPqQe3wr2Drk6GAXqlU2nb6IpaqZMK9sAjVgVZcuaAc489xGqQAxv+IcVxBvFrt1
         x28EoyE5+dd+tVMZyabg+Qi2e/t7Vzi6OCKDhWS/EHrdz3+wlRkoWnFCG+gRCCtHAua2
         MaS5lZWXX48+J0YLIKbLXkmaAqvat9197N+XYT7VWrppTie++euCmsr2pnlL2HHqxuLH
         MKQDa3SDJdk3Emj7fqBoKeXtxnHT4rhF/tpAiMXGGRE63I8eLKP6lVo0v3W+US9M7LED
         wuAuJoEGuAMzvlDSzssmDgUrZD5blwd/KvV7ku7s2fRRbmfclQK/czbZnhDOsbnhWpYz
         EW/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8p6XtSIof7SgBOH9CUQa/GsqiEyRx1pPjvyUjO5yNbX+mkwEUfVv011rkeEEPpbDsKI43SqXzF4PSQLiRg@vger.kernel.org
X-Gm-Message-State: AOJu0YzBC7XMgoz96jL8aYR32jTG2RTOMw/VJFkC7Mc880wiIOUA1puY
	jfqptA4GTzHiKhhHM9NTPIfh34lSYq9w8ERy+iKeJuDuWNCUdTbadGRg9bFfmSDsmj+Lkm2hONa
	YUWFoVqM=
X-Gm-Gg: AeBDiev24U2g7ZWMo7skcYV7k9VpTjwcvXzljORFSedqn43TGmRqknEs32aHK664XNQ
	wa7AqObXZBvzwdlN0e5PjYg12YovnhmSeQEafqUUToQQqpK+k6udwgucJgXtvuPDCXKYi+wwsEv
	8rGgAXcRLu2QLRmNmgH8HCJWjBCkikMbOy7qcEtWupqL1g9z4zrjKaLAGgjj6CF3E4TX0ndhQFD
	z4/H0RQ1uTUCN4fiu+s/yuuWgd0Gx2FoD4L33ZaB+eCvqlhn4EsTuK4Spr04cxk8yWKLshCU+T7
	ktUohpLrnUZoxR05oJSzhlHwe5dXxKz3bDQmi78mvxbft1V39PFGpIDFimfPTDRkbx07hIACMMM
	NPw8tCfSvkfQegHWadeuJj4lg3NglrokDMnmubixT6HlPTjgLVE1xEm4SoA8rGmzK4YcLEEK5Ge
	nuiOVY7ZnSDWgAXJ22EZ3zWoW6P1X2Ax3Ov/qc6p7ohqZgv8ix8XAOmTmv2SEN/s5DN/Du+GZMw
	p+esxSm6sbr
X-Received: by 2002:a05:6a20:9187:b0:3a2:dd8a:5087 with SMTP id adf61e73a8af0-3a2dd8a5ca7mr12577736637.46.1776895647889;
        Wed, 22 Apr 2026 15:07:27 -0700 (PDT)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f8f356sm13895264a12.4.2026.04.22.15.07.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2026 15:07:27 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v2] cache the string generated by reading
 /proc/filesystems
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260422181711.1340269-1-mjguzik@gmail.com>
Date: Wed, 22 Apr 2026 16:07:15 -0600
Cc: brauner@kernel.org,
 viro@zeniv.linux.org.uk,
 jack@suse.cz,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF9A814D-BABE-45FA-A6C4-2AAAD9CE2F21@dilger.ca>
References: <20260422181711.1340269-1-mjguzik@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On Apr 22, 2026, at 12:17, Mateusz Guzik <mjguzik@gmail.com> wrote:
>=20
> It is being read surprisingly often (e.g., by mkdir, ls and even =
sed!).

Yeah, it is sad that bloat continually grows to continually make fast
systems slow.

> This is lock-protected pointer chasing over a linked list to pay for
> sprintf for every fs (32 on my boxen).
>=20
> Instead cache the result.
>=20
> open+read+close cycle single-threaded (ops/s):
> before: 442732
> after: 1063462 (+140%)
>=20
> Here the main bottleneck is memcg.
>=20
> Scalability-wise problems are avoidable lockref trip on open and ref
> management for the file on procfs side.
>=20
> The file looks like a sterotypical C from the 90s, right down to an
> open-coded and slightly obfuscated linked list. I intentionally did =
not
> clean up any of it -- I think the file will be best served by a Rust
> rewrite when the time comes.
>=20
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>=20
> v2:
> - drop the procfs bits
> - touch up some comments
>=20
> I posted v1 last year =
https://lore.kernel.org/linux-fsdevel/20250329192821.822253-1-mjguzik@gmai=
l.com/
>=20
> but that ran into some procfs issues. the thing can be sped up
> regardless of the procfs problem.
>=20
> fs/filesystems.c | 144 ++++++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 137 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/filesystems.c b/fs/filesystems.c
>=20
> +static noinline int regen_filesystems_string(void)
> +{
> +	struct file_system_type *tmp;
> +	struct file_systems_string *old, *new;
> +	size_t newlen, usedlen;
> +	unsigned long gen;
> +
> +retry:
> +	lockdep_assert_not_held(&file_systems_lock);
> +
> +	newlen =3D 0;
> +	write_lock(&file_systems_lock);
> +	gen =3D file_systems_gen;
> +	tmp =3D file_systems;
> +
> +	/* pre-calc space for "%s\t%s\n" for each fs */
> +	while (tmp) {
> +		if (!(tmp->fs_flags & FS_REQUIRES_DEV))
> +			newlen +=3D strlen("nodev");
> +		newlen +=3D strlen("\t");
> +		newlen +=3D strlen(tmp->name);
> +		newlen +=3D strlen("\n");
> +		tmp =3D tmp->next;
> +	}
> +	write_unlock(&file_systems_lock);
> +
> +	new =3D kmalloc(offsetof(struct file_systems_string, string) + =
newlen + 1,
> +		      GFP_KERNEL);
> +	if (!new)
> +		return -ENOMEM;

This is introducing an error case where there was none before, in a
critical system file.  It would also be possible to fall back to
seq_printf() instead of sprinft() if no buffer is available.

> +	new->gen =3D gen;
> +	new->len =3D newlen;
> +	new->string[newlen] =3D '\0';
> +	write_lock(&file_systems_lock);
> +	old =3D file_systems_string;
> +
> +	/*
> +	 * Did someone beat us to it?
> +	 */
> +	if (old && old->gen =3D=3D file_systems_gen) {
> +		write_unlock(&file_systems_lock);
> +		kfree(new);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Did the list change in the meantime?
> +	 */
> +	if (gen !=3D file_systems_gen) {
> +		write_unlock(&file_systems_lock);
> +		kfree(new);
> +		goto retry;
> +	}
> +
> +	/*
> +	 * Populate the string.
> +	 *
> +	 * We know we have just enough space because we calculated the =
right
> +	 * size the previous time we had the lock and confirmed the list =
has
> +	 * not changed after reacquiring it.
> +	 */

It doesn't seem prudent to use raw sprintf() in a loop and justify this =
in
a comment, when the actual string generation is not performance =
critical.
This could use scnprintf() and be "safer" even if it "should just work" =
(tm).

> +	 usedlen =3D 0;
>  	tmp =3D file_systems;
>  	while (tmp) {
> -		seq_printf(m, "%s\t%s\n",
> +		usedlen +=3D sprintf(&new->string[usedlen], "%s\t%s\n",
>  			(tmp->fs_flags & FS_REQUIRES_DEV) ? "" : =
"nodev",
>  			tmp->name);
>  		tmp =3D tmp->next;
>  	}
> -	read_unlock(&file_systems_lock);
> +	BUG_ON(new->len !=3D strlen(new->string));

Adding a BUG_ON() here seems gratuitous, when there are lots of other
options to handle this case, especially if sprintf() didn't just corrupt
memory for some reason.  It could allocate a larger buffer and retry,
or in the worst case return an error instead of crashing the system.

> +
> +	/*
> +	 * Paired with consume fence in READ_ONCE() in =
filesystems_proc_show()
> +	 */
> +	smp_store_release(&file_systems_string, new);
> +	write_unlock(&file_systems_lock);
> +	kfree_rcu(old, rcufree);
>  	return 0;
>  }
>=20


Cheers, Andreas





