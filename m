Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5182041A501;
	Wed, 22 Jul 2026 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735953; cv=none; b=p/RaP9GqrhgxLsMyimgNmqKs3H1Om8XrS2JzwV8d89tVblVfXG8JysMvr4EnS7cE0hONF7Zx97z6GKmAy4UdBatDokvy6ZZqcZlYLBj9WvkuE65w09Q76mkNHBxUTLENoMWVfhUzj74SzxGf8dTnkMZ9HURH3/warLQpnPcVBMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735953; c=relaxed/simple;
	bh=ovdxwvAWRVrDlJaz62HOuk3XignNiSoaHXa5SU2T174=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Q8sSLOyqY7miuJMokirq88SKIXFVlYInzKjcCOVxt6K13IuKpLlul2xDnk/egIhoHm4xfRHDiMey74PHzH/MZ4m2YieCjWx5eByAUGKelAMseuQ6sKWi12daQRDvkPTZYWQYjsVmPTaLSEMw2EcfzZDWAVr6Z7qt/vG7KgrFwWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avVV55CJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avVV55CJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57311F000E9;
	Wed, 22 Jul 2026 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784735952;
	bh=jHAJXYDYaNZ5gxL1qCSFKgNVd3B79GW84exIfRUAmC8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=avVV55CJ7lao9oFT9t1UMifTjEnIbHVieQT8EVDjMcqt8u1dtBnT0/1mtTRC5jmbo
	 StHORgu6sy+HowiIuv66/jzLtdKuVpEQANXM4zsw30hTvG+B4yVu//7sbRt1f2z9ou
	 B+/a/wZx1HkWEI7QnFbEOUQXiAWYKmnlxuzbtFpQruyB5Lv/gVpSxXhsKqwGuMSKGK
	 tk0Tp4/ZDWXG1QWU7slIZxO0KFB5p+FeDf/uAYGHSRGwjMrR8yre1aKdHq7or0uSOX
	 ydABoWog2G9A48e9sEV4kIUW6JEwCczrDFH0kCMAXozPvkHHiwFsIQn6DL9Bb67coA
	 4+4R7B63lOWtg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] audit: add MOVE_MOUNT auxiliary record to log mount
 relocation
From: Christian Brauner <brauner@kernel.org>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com, 
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
 sgrubb@redhat.com
In-Reply-To: <20260713170035.4073532-1-rrobaina@redhat.com>
References: <20260713170035.4073532-1-rrobaina@redhat.com>
Date: Wed, 22 Jul 2026 17:59:07 +0200
Message-Id: <20260722-hecht-bauch-eiskunstlauf-7e2cab5ae9bc@brauner>
X-Mailer: b4 0.16-dev-2f6f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ovdxwvAWRVrDlJaz62HOuk3XignNiSoaHXa5SU2T174=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlvDj7MfLh+1+s/ZuW7xKy+HTbO3xOmGWjwPLHHc2/p
 R7t/91Z2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRN4mMDKdbfbdeFLrvdH9Z
 bewkrUeZz5atPpGz7fO5TcrLLojdfSPAyLDyyw5VkyV71hgt3mrzxndzxuHJqaLackoFAi1cicn
 yG/gA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-13 14:00 -0300, Ricardo Robaina wrote:
> Modern mount tools (util-linux >= 2.39.1) use the new mount API
> (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> syscall. The generic SYSCALL audit record logs the move_mount syscall
> but does not capture the flags argument, creating an audit gap for
> mount relocation operations.
> 
> Add a MOVE_MOUNT auxiliary record that logs the flags argument passed
> to move_mount(2). Pathnames and file descriptors are captured through
> existing PATH records and SYSCALL record arguments.
> 
>  ----
>  type=PATH : item=0 name=/mnt/test_src inode=1 dev=00:41 ...
>  type=SYSCALL : arch=x86_64 syscall=move_mount ...
>  type=MOVE_MOUNT : fs_flags=0x4
>  ----
>  type=PATH : item=0 name=/mnt/test_dst inode=27460862 dev=fc:00 ...
>  type=SYSCALL : arch=x86_64 syscall=move_mount ...
>  type=MOVE_MOUNT : fs_flags=0x4
> 
> Link: https://github.com/linux-audit/audit-kernel/issues/152
> Link: https://github.com/linux-audit/audit-kernel/issues/153
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

