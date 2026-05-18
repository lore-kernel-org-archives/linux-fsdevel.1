Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62035E1C7;
	Mon, 18 May 2026 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104575; cv=none; b=GtubOyBFrXar3SLiFwuH9kLFNdHE2L6//WVCfs8QBVFI+K4oRG87d5jTE0pLVy1Lgog3SBAQObMmxmlhprd1/uEB1ca5jcx12G/kQKwIdAk6WzTpCFiBQSTHOY0jCnQjyyZXUQJhR4z4+NJngLoQuNEhFomRe3PCSAJa9Us4S8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104575; c=relaxed/simple;
	bh=fzuOchQU3Wxc/EYI/qukVZIFcZR6K8d6oLn/uaKz89Y=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Vd84HaMIRyy2F2fP9+nE1TDyuWs9TOACF1M40C6qYV6Otd9PQUPcbV51YEfB2fr9VwjYHXgos1qDvEphKLmReFYz7vnn0dqH28gJX6ApBxv6CromRKBIFJeCDDVeYRlRS5aGN2cmNthEfbWfkAXlxo60tHa987buqVi+9Buthxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdr8Y2pz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdr8Y2pz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D03C2BCB7;
	Mon, 18 May 2026 11:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104575;
	bh=fzuOchQU3Wxc/EYI/qukVZIFcZR6K8d6oLn/uaKz89Y=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=Rdr8Y2pzApd3q2amLiMF99a4J+6uK10QG5Y+o9rBYuDt9STp8xKU0y4o5/ApivX1V
	 0+2kst3XV3Oj3ijT33WLI3K+vADwzo4jQpTmBgBSfQ2I3s8kKLwnodtqsEdcaJPp5T
	 vXZ74N5NN/ak67f+7A/Mo4Su1f07lZQDWzX14hCuQhdkPN9CKWcdRmTCwR7IGpj8jA
	 AAp0i9PF6mK9gyKpcCkcyfMPosZLzY8Q+n6IfJ59Hg4mb6Vw7PXMV8HQVNniFZuvIi
	 7DJMRp2OBlE5PtXS4BNIJSAHRJN/U+ZkUMSHClAZptmCzXJucqJ5f9okW9ebWY1Zw/
	 yqf1lt9T6TEdA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/3] writeback: use a per-sb counter to drain inode
 wb switches at umount
From: Christian Brauner <brauner@kernel.org>
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260517142147.3354909-4-libaokun@linux.alibaba.com>
References: <20260517142147.3354909-1-libaokun@linux.alibaba.com>
 <20260517142147.3354909-4-libaokun@linux.alibaba.com>
Date: Mon, 18 May 2026 13:42:49 +0200
Message-Id: <177910456953.488929.2169908940676707307.b4-review@b4>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fzuOchQU3Wxc/EYI/qukVZIFcZR6K8d6oLn/uaKz89Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRx/bbl27b937OGq5+tOdY1pce1CFZFH8zZM/9fvXTYG
 49FT/KbO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiksfwi/llVYlUStmsF2XB
 ilmlVuUWnoIiX5ZfYfZittPonPsymuG/t1ul4fWbWjXtfoJmZ1y89R8V9VwNz0wu+vr/WvEWz+u
 sAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sun, 17 May 2026 22:21:32 +0800, Baokun Li <libaokun@linux.alibaba.com> wrote:
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 9ae290547eb2..4282fcfe027b 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1215,38 +1209,30 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
> [ ... skip 38 lines ... ]
> -		 * in-flight switcher that already passed the SB_ACTIVE check
> -		 * to finish queueing its work, so flush_workqueue() below
> -		 * will then drain it.
> -		 */
> -		synchronize_rcu();
> +	while (atomic_read(&sb->s_isw_nr_in_flight)) {

Would probably be a bit nicer to just wait until the count is zero?
We have that pattern for inode_dio_wait(). So something like (untested):

static bool cgroup_writeback_finished(const struct super_block *sb)
{
	if (atomic_read(&sb->s_isw_nr_in_flight) == 0)
		return true;

   	flush_workqueue(isw_wq);
	return false;
}

void cgroup_writeback_wait(const struct super_block *sb)
{
	wait_var_event(&sb->s_isw_nr_in_flight, cgroup_writeback_finished(sb));
}

void cgroup_writeback_finish(const struct super_block *sb)
{
	if (atomic_dec_and_test(&sb->s_isw_nr_in_flight))
		wake_up_var(&sb->s_isw_nr_in_flight);
}

-- 
Christian Brauner <brauner@kernel.org>
