Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A581A2DC798
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724372; cv=none; b=qh9Krr8sbEn9yJrzh+YzDg1yURUeWCZiMWIRLlwIi1BfG8HeP0MaNFaTTbspQL+8wmbhO7X0FULb3gdzWlLsgGPzHS9y0jbp53bNOv+N3V+7WjYeQuIp0t5OEgVz14UzayimrSmJBwVq4F/WOGXLdVs0LXRvyX/wVGA6OqP6Nso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724372; c=relaxed/simple;
	bh=JjhKxmTKX40xv2aykBnwoXclVnZf67jQyqZpG3wnPHc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=u3OERwubiItXv0zuzZIMxhuaGGRMPPUAXFa7LwrvL87Z5Ux6IkQy4SchhiZgs22R79LyWxbTQ3GSGLFxWQyv5WSGxyPfgZ1DVdZxKMrTOHJq30rKBRCLzzVCNnPsWyZGb7703E/e2r9wEitRIU/+EamgXjyYho8FVZaKFc9oedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2Z2mOHz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2Z2mOHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603001F00A3A;
	Wed, 22 Jul 2026 12:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784724370;
	bh=SeVUSlJmslehYyxssgtUf1hbbQ6ah39iWYiK8vQnN+0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=P2Z2mOHzDBINS6iRGK6tNCjvOCooXZL5dNWvXMHrK0sRx8qEuuH5UrM0ZbpVxZ2k2
	 DMqRgAQb0v++17r+ZotbH6fH7IQuslGzVOM4KfMQZ+tTiXnPeisivEPpSAh0grM8xq
	 5MDyEms9jKm/xa0lUqNVqpOMuu470wZ+rDJRU0XRdljZZFDldfOJrQIBVtenY/hrcS
	 mOCBOY74EklCrrimxnBYJ9ypaWawvi9nuDv2gTfKf307Jrs19hpLLSOAtuL8faFbLI
	 PAUJ5yM5CFMk3Pnf8YG14ScBy4ixJYnoQrQBUB7aqt7OhxP8Z+cl6D8WN/tG10Ouab
	 LmXAavMwXa7GA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/4] VFS: add d_duplicate()
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20260701233128.3356519-5-neilb@ownmail.net>
References: <20260701233128.3356519-1-neilb@ownmail.net>
 <20260701233128.3356519-5-neilb@ownmail.net>
Date: Wed, 22 Jul 2026 14:45:57 +0200
Message-Id: <20260722-fallpauschalen-reparationen-stier-a05636d2f280@brauner>
X-Mailer: b4 0.16-dev-9dec3
X-Developer-Signature: v=1; a=openpgp-sha256; l=359; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JjhKxmTKX40xv2aykBnwoXclVnZf67jQyqZpG3wnPHc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQl7O6Ke5dgK3JX8es9Y+M5D5i7IuaXyIZtYH+vfFhfv
 u+coLRORykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETWizD8T19mvW2z42ODYD21
 S0f2sVZUMTG6bTgnFNl/9d26ctPoYkaGI5uT9F/wn15YdHbfz/2/DDi/pkxdW/vCzijs8v1YhzQ
 ObgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> +	spin_lock(&parent->d_lock);
> +	new->d_parent = dget_dlock(parent);
> +	hlist_add_head(&new->d_sib, &parent->d_children);
> +	if (parent->d_flags & DCACHE_DISCONNECTED)
> +		new->d_flags |= DCACHE_DISCONNECTED;
> +	spin_unlock(&dentry->d_parent->d_lock);

Please spin_unlock(&parent->d_lock) as you're using that to lock so it's symmetric.

-- 

