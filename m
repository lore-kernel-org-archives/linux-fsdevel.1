Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1192652AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783952838; cv=none; b=eWnLoQWJP5qyHikM+xmckqrq+w70MwHr/UzwQ5yY8SBjF5Z7iZFJ5Rd3OJUKMxvK4dgC8pdAUx/JCT7i2avTEB8ODFUnzFwxqwM7G+1A+inX5MCUOntyZ6723snDaetIubooBiL9ix6xFBvbQ4bXyoHiyQjSCQnz3gq7cbYqpw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783952838; c=relaxed/simple;
	bh=/r2Xi6N18qyCVZAPKCTF82u/kygTPeE7Zl+iMFBUwAo=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=E0FS4g5KJvVN169iGFxKqJvXSRgsVhA4HiW9ymQIQEAOvqoP9qPu2Qrh3QQIMxiefobFb1yP+o2v+FIek9Hs7gus/ACo5ZLO5SUVw9RfbWOk9lmeABzIT2xyRak8HZ2PiuNppWa9oPhN4Ltl9fQVNwAC/TO7S0racTzPX6ZC3yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=bFnjf3GZ; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="bFnjf3GZ"
X-KPN-MessageId: f0cdd940-7ec6-11f1-8f54-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f0cdd940-7ec6-11f1-8f54-005056992ed3;
	Mon, 13 Jul 2026 16:27:13 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id f0cad273-7ec6-11f1-b307-0050569977a2;
	Mon, 13 Jul 2026 16:27:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=iaLgv2BDveiB9cTDQA1hlKsSjdSyePkmq764Gt+8i9o=;
	b=bFnjf3GZsDi4jaX0Yga/FoiycnY0KvMHcY7b3zcmxMu1yp4aAOVYsvBjgNxyfEALxLbCP/w61x2q1
	 FXv/VefpQt0Tg6FIB6iBqusW/4yhYGWMiKH4DlJb6mbGWvpp6WcfvANNVWs5066Ed1iVd40M4Hb/xj
	 qX+PcgjJPm6j0q4wQgI9pLxFZTEcfNWZBmX0rLxKFS5+fmFDi4nElwv/3GBtkfAsL+qGHM+X6gRkpy
	 tW2MhxSMZ1vy/7Z5KMpiWhdntEalBXtnnMNdn9LN63kternvYxwph6w2KCzk2rWKS6bgT6JG93Hz1K
	 gcIIHtB6FTSIG/Ajkn/6tAopCGtel4w==
X-KPN-MID: 33|qsuEQdNEvuBFtwNk6ROruy+2Y66UI1YowGqXh3sB8ITQXHEKkfDqFoZq6C7U0wp
 ZHv0edVJqpLD2k5CjKAKM/pxiQOxwcHg2o6whg2OIDXE=
X-CMASSUN: 33|DKpEomnx7w/OtmUBXF1IrZfKmSs9bQZtxdkKUN35bE7va/CfAKBEMSFCM/wu/BZ
 Ir3r8nWsNq1pvgX/egS4yNA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id f0bbb2c8-7ec6-11f1-916a-005056995d6c;
	Mon, 13 Jul 2026 16:27:13 +0200 (CEST)
Date: Mon, 13 Jul 2026 16:27:13 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Message-ID: <299644823.863357.1783952833258@kpc.webmail.kpnmail.nl>
Subject: Re: [PATCH v3 09/24] binfmt_misc: rename Node to struct
 binfmt_misc_entry
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

On Fri, Jul 10, 2026 at 11:33:10AM +0200, Christian Brauner wrote:
> The CamelCase Node typedef is a 1997 leftover and hides that this is
> a plain struct. Call it what it is: struct binfmt_misc_entry, matching
> struct binfmt_misc that it hangs off of and the entry bit and flag
> enums. Drop the typedef, switch the size computations in
> create_entry() to sizeof(*e) and adjust the comments that still
> referred to the old name.
> 
> No functional change.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 60 +++++++++++++++++++++++++++++---------------------------
>  1 file changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 98ad1383ba6b..9be57f387524 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -56,7 +56,7 @@ enum binfmt_misc_entry_flags {
>  	MISC_FMT_OPEN_FILE	= (1U << 28),
>  };
>  
> -typedef struct {
> +struct binfmt_misc_entry {
>  	struct hlist_node node;
>  	unsigned long flags;		/* type, status, etc. */
>  	int offset;			/* offset of magic */
> @@ -69,7 +69,7 @@ typedef struct {
>  	struct file *interp_file;
>  	refcount_t users;		/* sync removal with load_misc_binary() */
>  	struct rcu_head rcu;
> -} Node;
> +};
>  
>  static struct file_system_type bm_fs_type;
>  
> @@ -84,7 +84,7 @@ static struct file_system_type bm_fs_type;
>   *  - interp: ~50 bytes
>   *  - flags:  5 bytes
>   * Round that up a bit, and then back off to hold the internal data
> - * (like struct Node).
> + * (like struct binfmt_misc_entry).
>   */
>  #define MAX_REGISTER_LENGTH 1920
>  
> @@ -100,11 +100,11 @@ static struct file_system_type bm_fs_type;
>   *
>   * Return: binary type list entry on success, NULL on failure
>   */
> -static Node *search_binfmt_handler(struct binfmt_misc *misc,
> -				   struct linux_binprm *bprm)
> +static struct binfmt_misc_entry *
> +search_binfmt_handler(struct binfmt_misc *misc, struct linux_binprm *bprm)
>  {
>  	char *p = strrchr(bprm->interp, '.');
> -	Node *e;
> +	struct binfmt_misc_entry *e;
>  
>  	/* Walk all the registered handlers. */
>  	hlist_for_each_entry_rcu(e, &misc->entries, node) {
> @@ -153,10 +153,10 @@ static Node *search_binfmt_handler(struct binfmt_misc *misc,
>   *
>   * Return: binary type list entry on success, NULL on failure
>   */
> -static Node *get_binfmt_handler(struct binfmt_misc *misc,
> -				struct linux_binprm *bprm)
> +static struct binfmt_misc_entry *get_binfmt_handler(struct binfmt_misc *misc,
> +						    struct linux_binprm *bprm)
>  {
> -	Node *e;
> +	struct binfmt_misc_entry *e;
>  
>  	guard(rcu)();
>  	do {
> @@ -166,14 +166,14 @@ static Node *get_binfmt_handler(struct binfmt_misc *misc,
>  }
>  
>  /**
> - * put_binfmt_handler - put binary handler node
> - * @e: node to put
> + * put_binfmt_handler - put binary handler entry
> + * @e: entry to put
>   *
> - * Free node syncing with load_misc_binary() and defer final free to
> + * Free entry syncing with load_misc_binary() and defer final free to
>   * load_misc_binary() in case it is using the binary type handler we were
>   * requested to remove.
>   */
> -static void put_binfmt_handler(Node *e)
> +static void put_binfmt_handler(struct binfmt_misc_entry *e)
>  {
>  	if (refcount_dec_and_test(&e->users)) {
>  		if (e->flags & MISC_FMT_OPEN_FILE) {
> @@ -219,7 +219,7 @@ static struct binfmt_misc *load_binfmt_misc(void)
>   */
>  static int load_misc_binary(struct linux_binprm *bprm)
>  {
> -	Node *fmt;
> +	struct binfmt_misc_entry *fmt;
>  	struct file *interp_file = NULL;
>  	int retval = -ENOEXEC;
>  	struct binfmt_misc *misc;
> @@ -290,7 +290,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  ret:
>  
>  	/*
> -	 * If we actually put the node here all concurrent calls to
> +	 * If we actually put the entry here all concurrent calls to
>  	 * load_misc_binary() will have finished. We also know
>  	 * that for the refcount to be zero someone must have concurently
>  	 * removed the binary type handler from the list and it's our job to
> @@ -326,7 +326,7 @@ static char *scanarg(char *s, char del)
>  	return s;
>  }
>  
> -static char *check_special_flags(char *sfs, Node *e)
> +static char *check_special_flags(char *sfs, struct binfmt_misc_entry *e)
>  {
>  	char *p = sfs;
>  	int cont = 1;
> @@ -370,9 +370,10 @@ static char *check_special_flags(char *sfs, Node *e)
>   * ':name:type:offset:magic:mask:interpreter:flags'
>   * where the ':' is the IFS, that can be chosen with the first char
>   */
> -static Node *create_entry(const char __user *buffer, size_t count)
> +static struct binfmt_misc_entry *create_entry(const char __user *buffer,
> +					      size_t count)
>  {
> -	Node *e;
> +	struct binfmt_misc_entry *e;
>  	int memsize, err;
>  	char *buf, *p;
>  	char del;
> @@ -385,14 +386,14 @@ static Node *create_entry(const char __user *buffer, size_t count)
>  		goto out;
>  
>  	err = -ENOMEM;
> -	memsize = sizeof(Node) + count + 8;
> +	memsize = sizeof(*e) + count + 8;
>  	e = kmalloc(memsize, GFP_KERNEL_ACCOUNT);
>  	if (!e)
>  		goto out;
>  
> -	p = buf = (char *)e + sizeof(Node);
> +	p = buf = (char *)e + sizeof(*e);
>  
> -	memset(e, 0, sizeof(Node));
> +	memset(e, 0, sizeof(*e));
>  	if (copy_from_user(buf, buffer, count))
>  		goto efault;
>  
> @@ -602,7 +603,7 @@ static int parse_command(const char __user *buffer, size_t count)
>  
>  /* generic stuff */
>  
> -static void entry_status(Node *e, char *page)
> +static void entry_status(struct binfmt_misc_entry *e, char *page)
>  {
>  	char *dp = page;
>  	const char *status = "disabled";
> @@ -686,7 +687,7 @@ static struct binfmt_misc *i_binfmt_misc(struct inode *inode)
>  */
>  static void bm_evict_inode(struct inode *inode)
>  {
> -	Node *e = inode->i_private;
> +	struct binfmt_misc_entry *e = inode->i_private;
>  
>  	clear_inode(inode);
>  
> @@ -714,7 +715,8 @@ static void bm_evict_inode(struct inode *inode)
>   * to use writes to files in order to delete binary type handlers. But it has
>   * worked for so long that it's not a pressing issue.
>   */
> -static void remove_binfmt_handler(struct binfmt_misc *misc, Node *e)
> +static void remove_binfmt_handler(struct binfmt_misc *misc,
> +				  struct binfmt_misc_entry *e)
>  {
>  	spin_lock(&misc->entries_lock);
>  	hlist_del_init_rcu(&e->node);
> @@ -727,7 +729,7 @@ static void remove_binfmt_handler(struct binfmt_misc *misc, Node *e)
>  static ssize_t
>  bm_entry_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
>  {
> -	Node *e = file_inode(file)->i_private;
> +	struct binfmt_misc_entry *e = file_inode(file)->i_private;
>  	ssize_t res;
>  	char *page;
>  
> @@ -747,7 +749,7 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
>  				size_t count, loff_t *ppos)
>  {
>  	struct inode *inode = file_inode(file);
> -	Node *e = inode->i_private;
> +	struct binfmt_misc_entry *e = inode->i_private;
>  	int res = parse_command(buffer, count);
>  
>  	switch (res) {
> @@ -796,7 +798,7 @@ static const struct file_operations bm_entry_operations = {
>  /* /register */
>  
>  /* add to filesystem */
> -static int add_entry(Node *e, struct super_block *sb)
> +static int add_entry(struct binfmt_misc_entry *e, struct super_block *sb)
>  {
>  	struct dentry *dentry = simple_start_creating(sb->s_root, e->name);
>  	struct inode *inode;
> @@ -828,7 +830,7 @@ static int add_entry(Node *e, struct super_block *sb)
>  static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>  			       size_t count, loff_t *ppos)
>  {
> -	Node *e;
> +	struct binfmt_misc_entry *e;
>  	struct super_block *sb = file_inode(file)->i_sb;
>  	int err = 0;
>  	struct file *f = NULL;
> @@ -894,7 +896,7 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
>  	int res = parse_command(buffer, count);
>  	struct hlist_node *next;
>  	struct inode *inode;
> -	Node *e;
> +	struct binfmt_misc_entry *e;
>  
>  	misc = i_binfmt_misc(file_inode(file));
>  	switch (res) {
> 
> -- 
> 2.53.0
> 

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
