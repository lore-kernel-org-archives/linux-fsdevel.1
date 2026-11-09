Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217103;
	b=raSnY1wzu/7dfD7GRxz6A0vChr230JfZ+lIU7RFt/6yEBYc60ZvEzS9feyerv8DMisxc
	 4e/8rRYqAagHqx9AYUoQ5SgQFJJ6aH+8vBHnYs6m9pwJDse/Q/HR1AyDBZI0AMW01Eue2
	 SuDD263H/OIQ+T9yHLe11vWYSqbWPxAINlV8BKt2SviD3Y+haCDJaBVbkVjTiLpRO8mzX
	 J/oOz+sG7kRLPnfDijLQSS/rZLBtLSZ0i+PDXTsO5bx334qOLcaYCh+K7dT6ZKbIcHsYc
	 1ydujCeZkK2TM6d+zKF64BONH5FatidXjUUFU1voZQ0yYnRTN4LyoZv40J1ysxJqc0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=vMJSg0lmacnY+UcGHVNgSDJi3N4uyY4O9jJ0C/cw0zk=;
	b=zHu1KSnmlC2sRpdsxHAtlNkQHYzOO+FDpjrwb47IdHhI6v/8u1GJatLiLGfnvjmllA2Z
	 DfIGr3IglikfD3VyMGPLa5sXiCm2tPUQIDe4EplL4u8rUO5TGVbXBdiqXw+eJaA1ZUtOo
	 9cUbpQAD+1xR/+2ps5BMHC7eLSD0CF8PrjKneWvZ9YsAVOnnhUC/oNKYiddyVLVb5dFG6
	 /wLLqWgbC3/ywWssl0EL2J+wVPUbR5jHMBY/uUm7LKEhv1QdYIANM31Qb0AuzGOprFoE9
	 dZpfJmt2VJqnmXkCaCv9l8BtluX84Zi/xYTEDLyQBmoLoCWTOyEYKMewWiGykot6S5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KHuzvPDs;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE87E606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 09:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE87E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KHuzvPDs
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36dbde64409so1175766eec.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 01:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794217102; x=1794821902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vMJSg0lmacnY+UcGHVNgSDJi3N4uyY4O9jJ0C/cw0zk=;
        b=KHuzvPDs+6IUSeE0sG+wgkRMym9JU7b7w/TEihVG7UtY5yKSCq3SU4YIsvUbbbqDUy
         DxddA6ecwe9WpOv46viIOiPIdVbetXLJnqlGywEHNMrGl2mdO89xFMffuFFs6WiF/OiR
         UVgbTxGt3rnTojai5e9wSzLKL+1PPCfI5Ua7Sat8QZBifbNzW+/gfXjwD0+0sY3Xl2ab
         9JXB8ldl9AWkZf44j0wGcmqdlLQahqrp0LC1NhwZ7AZT3FZkrI26FymnMvf0uQXsC3uL
         OOs5iEp7DtEdgrQZTn9/E76vpAZfksxvl3Q8hIXdktGmRE1N8EjlV2HKKzTior0FeMQi
         uXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217102; x=1794821902;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vMJSg0lmacnY+UcGHVNgSDJi3N4uyY4O9jJ0C/cw0zk=;
        b=JLS4/yDhdHzRUy3rP8n4monXdBJB8YigVl7AZ8jbSEJ+aHQbjcmp4pqal9R8vz1tfr
         UOgKT6YsK12vdwmmwQMhYXSEb07pzVrKmOwalDv8ql54xo74/PSiqj0IqJP0+kKGJL4K
         kYLWU6gYxV5AumNeV4QpIAlPTNDi/4I2XN/58N2+hUxyk3AiIye1u92cbTOyvE+sGkA6
         IkCpEzljnU9lPoLydO93o4Mr0vY/PfYMCymTT+boHFvV7d+0d5xTt2Ebr6QS5AJqKNdN
         sD2d3ur+cGv1VZR3koSHxv2Sn1kp5ZCMvpU/DG/tl/YcgiQ5XV+xYxtnzwT+mHC+avJi
         gZ5Q==
X-Gm-Message-State: APuU4Z8kSEguxz553EH6dp8W4oOhuCPedUML1OAPogW2lGyNLZqBagfX
	uAvKLMG4Ll8T8GEeBD+R5aMuOvHiWZmWdCxt+PjKL8i39CgkYZp+trjmn8YwqzmElRs=
X-Gm-Gg: AYBFou1BtTcjpXTHTYV9TpfE+ADo9WH/pLxdft9og2FtnQQiD1st95rV0snFpJYHj62
	wCaQKUmWka3kZgGaO31916ZwcucHWk735s/mzcCE2HjeSGEXqti3rz+l0Wy7GztqAaNmhzE2nFN
	lwmkYFO95BXvDNxnSoMTDhd0hQXX8kH0sHCWfCyq+7r/iCTi7WtIhaC1OM1/okEIgxZ/LaBoFXy
	ep+0Byve6U8XN7H7X8RdLEPjhEnW3yDpZMj0kA4xRjHruWNOpcp1qkXNGOsJsbPQ2/JDBJOxs/X
	XPGmOhQoFg7d6WmwFo1IQLFdbJk1zm54eN5u5Y7tktE+x5q1BllTDqV+00dRiYrod9bPmjBX183
	a4mZ6Jk5lFMOxrTM6d5xfDW1gujU2klDlK2f2cAx6+Zb1uKTj2P6miul9/uYqz6wj7j7WmMgm9R
	A4iwRoDBT8H0GLp9MghmbCCLdKIvxksoX/1nnhz0wjBDEWKfTQG3bYYQLQIhCqlE52wC0FNbll4
	cTD0s45XJIh7IqHrT4Tog7LJgY4u2T5jr/9zcgBosq0Ct9Oef1mMW0kuYTa7nDtEFf8JjoWBe0N
	viqtfnl51NiDMyZv7R3+Pzkudagzq4aRWCJFkErviZzpzUfK0KyaxMFsaFRlx8xD0uYMz9Jm
X-Received: by 2002:a05:7301:d80e:10b0:36a:50ec:db3f with SMTP id 5a478bee46e88-372575c557amr6835812eec.7.1794217101438;
        Mon, 09 Nov 2026 01:38:21 -0800 (PST)
Received: from [100.81.10.186] ([61.213.176.59])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372669d2826sm12719426eec.29.2026.11.09.01.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 01:38:20 -0800 (PST)
Message-ID: <29bf4bce-cdb8-425c-8090-d8d84a749a73@bytedance.com>
Date: Mon, 9 Nov 2026 17:38:17 +0800
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: account filesystem bdev caches as kernel files
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, axboe@kernel.dk, viro@zeniv.linux.org.uk,
 brauner@kernel.org, akpm@linux-foundation.org, tj@kernel.org
References: <20261008130747.2868338-1-sunjunchao@bytedance.com>
 <3xivdukdcs45x2lql3fh3pogrkeb3piiexo2np4xscmz5yk4ot@jqvlshpakn4c>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <3xivdukdcs45x2lql3fh3pogrkeb3piiexo2np4xscmz5yk4ot@jqvlshpakn4c>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/26 4:58 PM, Jan Kara wrote:
> On Thu 08-10-26 21:07:47, Julian Sun wrote:
>> Filesystems such as ext4 use buffer heads to cache shared metadata in
>> the bdev mapping. Charging these pages to individual memcgs can trigger
>> foreign writeback of the bdev inode's entire owner wb, including
>> unrelated file data.
>>
>> Following the proposal in the linked discussion, set AS_KERNEL_FILE on
>> the bdev mapping while it is used by a filesystem, so newly allocated
>> cache pages are accounted to the root memcg. Empty the mapping before
>> changing the flag to keep folio insertion and removal accounting
>> consistent.
>>
>> Multiple EROFS superblocks can share an extra data device. For example,
>> two metadata images on /dev/loop0 and /dev/loop1 can reference the same
>> data blob on /dev/loop2:
>>
>>   mount -t erofs -o ro,device=/dev/loop2 /dev/loop0 /mnt/a
>>   mount -t erofs -o ro,device=/dev/loop2 /dev/loop1 /mnt/b
>>
>> Unmounting /mnt/a must not clear AS_KERNEL_FILE on /dev/loop2 while
>> /mnt/b still uses it. Keep the flag set until the last filesystem user
>> releases the device.
>>
>> bd_openers includes raw-device opens that may outlive filesystem
>> users, while bd_holders also counts partition claims on the whole
>> device. Neither counts filesystem users of this mapping, so add
>> bd_fs_users, protected by the bdev inode's i_rwsem.
>>
>> Update this count in fs_bdev_register() and fs_bdev_unregister().
>> These hooks cover both device-open helpers and callers such as btrfs
>> that unregister a device and close it separately, without calling
>> fs_bdev_file_release().
>>
>> Buffered access to the mounted raw device also charges new cache
>> pages to the root memcg. Such access is normally restricted to
>> privileged users. Pages cached in ordinary file mappings retain their
>> existing memcg accounting.
>>
>> For filesystems that cache metadata in the bdev mapping, the benefit
>> is expected to be most pronounced when multiple cgroups perform
>> buffered overwrites alongside direct I/O on the same bandwidth-limited
>> device, such as an HDD. Frequent foreign writeback
>> reduces write coalescing, producing additional I/O that can saturate
>> the device. Direct I/O bypasses the page cache and competes with this
>> writeback traffic for device bandwidth.
>>
>> An ext4 test combined repeated buffered overwrites of a 256 MiB file
>> with foreground direct writes, while four source memcgs generated
>> metadata and buffered writes. Device write bandwidth was capped at
>> 200 MiB/s. In one baseline/patched pair, background file write I/O,
>> including final sync, fell from 6.178 GiB to 1.652 GiB (-73.3%).
>> Foreground bandwidth rose from 149.70 MiB/s to 184.19 MiB/s (+23.0%),
>> and completion time fell from 109.444 s to 88.951 s (-18.7%).
>>
>> Link: https://lore.kernel.org/cgroups/20260925064444.3944820-1-sunjunchao@bytedance.com/T/#m55ee048deb0aad4d1f2293978f25ee6904a5725a
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> 
> Good catch with EROFS. The patch looks good to me so feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> FWIW the problem pointed by Sashiko looks real but it's a preexisting issue
> with broken bdev write locking when falling back to buffered IO. So it
> isn't much related to your patch.
> 
> 								Honza
> 
>> ---
>>  block/bdev.c              |  2 +-
>>  fs/super.c                | 59 +++++++++++++++++++++++++++++++++++++--
>>  include/linux/blk_types.h |  1 +
>>  include/linux/blkdev.h    |  1 +
>>  4 files changed, 60 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/bdev.c b/block/bdev.c
>> index cd8323083740..766e170286ca 100644
>> --- a/block/bdev.c
>> +++ b/block/bdev.c
>> @@ -79,7 +79,7 @@ static void bdev_write_inode(struct block_device *bdev)
>>  }
>>  
>>  /* Kill _all_ buffers and pagecache , dirty or not.. */
>> -static void kill_bdev(struct block_device *bdev)
>> +void kill_bdev(struct block_device *bdev)
>>  {
>>  	struct address_space *mapping = bdev->bd_mapping;
>>  
>> diff --git a/fs/super.c b/fs/super.c
>> index 9d4025213521..7d271bb4cc6d 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/blkdev.h>
>>  #include <linux/memcontrol.h>
>> +#include <linux/pagemap.h>
>>  #include <linux/rhashtable.h>
>>  #include <linux/mount.h>
>>  #include <linux/security.h>
>> @@ -1644,6 +1645,55 @@ static struct super_dev *super_dev_lookup(dev_t dev, struct super_block *sb)
>>  	return NULL;
>>  }
>>  
>> +/*
>> + * Filesystem metadata is shared across users and should be accounted to the
>> + * root cgroup. Charging it to individual cgroups can trigger foreign writeback
>> + * of the bdev inode's entire owner wb, including unrelated file data. For
>> + * buffered overwrites, premature writeback reduces write coalescing and
>> + * competes with foreground I/O, particularly on bandwidth-limited devices.
>> + * This foreign writeback problem primarily affects filesystems such as
>> + * ext4 that cache metadata in the bdev mapping using buffer heads.
>> + *
>> + * Raw buffered I/O also uses kernel-file accounting while a filesystem uses
>> + * the device. This is independent of CONFIG_BLK_DEV_WRITE_MOUNTED: writes to
>> + * a mounted device are dangerous administrative operations, and charging
>> + * their cache to the root cgroup is acceptable.
>> + */
>> +static void fs_bdev_set_kernel_file(struct block_device *bdev, bool enable)
>> +{
>> +	struct address_space *mapping = bdev->bd_mapping;
>> +	struct inode *inode = mapping->host;
>> +
>> +	inode_lock(inode);
>> +	/*
>> +	 * Multiple superblocks can share an extra device, as in EROFS.
>> +	 * Switch accounting only for the first user and the last release.
>> +	 * Raw openers may outlive all filesystem users, so bd_openers cannot
>> +	 * determine when to restore ordinary page-cache accounting.
>> +	 * Count at registration/unregistration: btrfs can unregister a device
>> +	 * and close it separately, bypassing fs_bdev_file_release().
>> +	 */
>> +	if (enable) {
>> +		if (bdev->bd_fs_users++)
>> +			goto out;
>> +	} else {
>> +		if (--bdev->bd_fs_users)
>> +			goto out;
>> +	}
>> +
>> +	filemap_invalidate_lock(mapping);
>> +	/* Folio removal must use the same accounting mode as insertion. */
>> +	sync_blockdev(bdev);
>> +	kill_bdev(bdev);
>> +	if (enable)
>> +		set_bit(AS_KERNEL_FILE, &mapping->flags);
>> +	else
>> +		clear_bit(AS_KERNEL_FILE, &mapping->flags);
>> +	filemap_invalidate_unlock(mapping);
>> +out:
>> +	inode_unlock(inode);
>> +}
>> +
>>  static int fs_bdev_register(struct file *bdev_file, struct super_block *sb)
>>  {
>>  	struct super_dev *sb_dev __free(kfree) = NULL;
>> @@ -1654,7 +1704,7 @@ static int fs_bdev_register(struct file *bdev_file, struct super_block *sb)
>>  		sb_dev = super_dev_lookup(dev, sb);
>>  		if (sb_dev && refcount_inc_not_zero(&sb_dev->sd_ref)) {
>>  			retain_and_null_ptr(sb_dev);
>> -			return 0;
>> +			goto registered;
>>  		}
>>  	}
>>  
>> @@ -1674,7 +1724,11 @@ static int fs_bdev_register(struct file *bdev_file, struct super_block *sb)
>>  	}
>>  
>>  	retain_and_null_ptr(sb_dev);
>> -	return err;
>> +	if (err)
>> +		return err;
>> +registered:
>> +	fs_bdev_set_kernel_file(file_bdev(bdev_file), true);
>> +	return 0;
>>  }
>>  
>>  /**
>> @@ -1765,6 +1819,7 @@ void fs_bdev_unregister(struct file *bdev_file, struct super_block *sb)
>>  	sb_dev = super_dev_lookup(dev, sb);
>>  	rcu_read_unlock();
>>  	super_dev_put(sb_dev);
>> +	fs_bdev_set_kernel_file(file_bdev(bdev_file), false);
>>  }
>>  EXPORT_SYMBOL_GPL(fs_bdev_unregister);
>>  
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index 98e21b4cbf32..19daea93bdec 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -58,6 +58,7 @@ struct block_device {
>>  	struct address_space	*bd_mapping;	/* page cache */
>>  
>>  	atomic_t		bd_openers;
>> +	unsigned int		bd_fs_users; /* Protected by bd_mapping->host->i_rwsem. */
>>  	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
>>  	void *			bd_claiming;
>>  	void *			bd_holder;
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 4f7905c3412b..f84dff95eae7 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1706,6 +1706,7 @@ bool disk_live(struct gendisk *disk);
>>  unsigned int block_size(struct block_device *bdev);
>>  
>>  #ifdef CONFIG_BLOCK
>> +void kill_bdev(struct block_device *bdev);
>>  void invalidate_bdev(struct block_device *bdev);
>>  int sync_blockdev(struct block_device *bdev);
>>  int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
>> -- 
>> 2.39.5
>>

Hi Jan, Christian,

Thanks for the review, Jan.

Christian, would you be willing to pick this up for linux-next,
with Jan's Reviewed-by? Please let me know if anything else is
needed from my side.

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>
