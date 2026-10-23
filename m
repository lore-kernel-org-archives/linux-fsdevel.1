Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747992;
	b=xdJlDMH6eNezsZKaboHL9ypMXVFyEZMilsXrl8oexZoxPAhSEuFXU0o//4iPfsZ/TGqk
	 oNUCzjfN0pD3X9r1PapRNTOM9deof/1bUFx7IvkuRSkfSOiCIJmLqOdxPztDIrQoHt+se
	 3REkLSQLPYYgOtl9Ev56lx9vhjBDuGgkzXdv6YpI3xcPRKwDJUOhviGlDZ8m+mKQ+Btqn
	 tTZMbwfXgTVTzYzm1OOj4noJBoKxAXHX7A9eul0xZunj5S2AJsLlwoCWTdyvHLjeF5iXR
	 5yJgUpJA7G3sVrLynsBK+b58dNzjvI63rRFJfn5+V3CjoXTZxd/RNr7XICpAVEUHeyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747992;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=9Yan1DVOjmP8uIPkYofbwGDlESd7xUK0NzsOPoIBE0Y=;
	b=5awjp4uh+vgkI7kOmHs2+tl6Y1jAGABE2oEVGhfTFEeAj2BG47plhwyO/VQjsYYeIopD
	 z0V5ge0DM+uSIT3p+Ebg07xk+cieab4oDAqj4/xK2g/7fGNPtXcCDWofpIi0BL4fDHde3
	 gQbONc/dPkM4zZZbnIOCq+57igzVKLmNHcrWJIQnBd6e8oqxMFK3S39X7IwVP+T9t26ug
	 ZFkTQJfCQgVarJYSvArr3EfJo23d+zbmoVexoBCmuPGnGAFt0KPOm2N6UStPyIi0LZgHV
	 gXNER42GECaddktjD2pNfyPrPU2hCnwKLbFdj5sQJNO4BrPqBpodWJQ3zj1q+tILJpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FA9giRZs;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932DD606A31A;
	Fri, 23 Oct 2026 09:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 932DD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FA9giRZs
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9Yan1DVOjmP8uIPkYofbwGDlESd7xUK0NzsOPoIBE0Y=;
	b=FA9giRZsyy8K9j/wKggr26pXFTUkr9T7A1nMl+TyB2FjbD8FQVOpf2o9o6Fn5arze7bE71ina
	giThjHRp5OuE/nLZK6+3xfsZ3oUgLzB2ENMG0FdmhfI4LuvMUL4a50IBdUshEtN8lxPIvFQBOYu
	nyDPyHcUufZauiKfKDDN070=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4j9yVm5Kd8zmV7t;
	Fri, 23 Oct 2026 17:33:04 +0800 (CST)
Received: from dggpemr200001.china.huawei.com (unknown [7.185.36.96])
	by mail.maildlp.com (Postfix) with ESMTPS id F0ED940578;
	Fri, 23 Oct 2026 17:33:07 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr200001.china.huawei.com
 (7.185.36.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 23 Oct
 2026 17:33:07 +0800
From: Ran Hongyun <ranhongyun1@huawei.com>
To: <drifabdelmalekmohamedsaid@gmail.com>
CC: <leitao@debian.org>, <a.hindborg@kernel.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ranhongyun1@huawei.com>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: Re: [PATCH] configfs: fix slab-UAF Write in config_item_put
Date: Fri, 23 Oct 2026 17:25:41 +0800
Message-ID: <20261023092541.1858529-1-ranhongyun1@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261017123748.4430-1-drifabdelmalekmohamedsaid@gmail.com>
References: <20261017123748.4430-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemr200001.china.huawei.com (7.185.36.96)

Hi Drif,

I hit the same issue and took a look at your patch. I think there is
still a race window in this approach.

> +	parent_item = configfs_get_config_item(dentry->d_parent);
> +	if (!parent_item) {
> +		ret = -ENOENT;
> +		goto out_put_target;
> +	}

configfs_get_config_item() relies on d_unhashed() to decide whether
parent_item is still alive, but the unhash happens in detach_groups()
via d_delete(), which runs *outside* inode_lock():

  configfs_rmdir:
    detach_groups():
      inode_lock(child);
      configfs_detach_group(...);
      inode_unlock(child);          // lock released
      d_delete(child);              // unhash happens here, no lock held
      dput(child);

So between inode_unlock(child) and d_delete(child), the child dentry is
still hashed.  If configfs_symlink() re-acquires the inode lock and calls
configfs_get_config_item() in that window, it gets a non-NULL
parent_item.  rmdir() then proceeds to kfree() the containing object,
and the subsequent allow_link() / config_item_put() still triggers UAF.

A simpler fix would be to check CONFIGFS_USET_DROPPING on the parent
configfs_dirent after re-locking.  I posted such a patch here:

  https://lore.kernel.org/all/20261023091102.1848219-1-ranhongyun1@huawei.com/

Thanks,
Ran Hongyun
